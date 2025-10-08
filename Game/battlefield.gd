extends Node2D

#todo
#a scene to select player number

var player = preload("res://Game/Player.tscn")
var intermission = preload("res://Game/intermission/intermission.tscn")
var winningScreen = preload("res://Winning menu/Winning menu.tscn")
@onready var pause_menu = $pauseMenu
var tanks: Array = []

enum gameStates {IN_FIGHT, INTERMISSION, COUNTDOWN}
var gameState = gameStates.COUNTDOWN

var spawns: Array = []

func _ready() -> void:
	cursorManager.disableCursors()
	
	for player in global.playersData:
		player.reset(player)
	
	var map = global.maps[randi_range(0, global.maps.size()-1)].instantiate()
	
	if not map.get_node("spawn").get_child(0).name in ["1", "2", "3", "4"]:
		spawns.append(PolygonRandomPointGenerator.new(map.get_node("spawn").get_child(0).polygon))
	else:
		for i in range(4):
			spawns.append(PolygonRandomPointGenerator.new(map.get_node("spawn").get_node(str(i+1)).polygon))
	$map.add_child(map)
	
	global.forEachPlayingPlayer(func(i):
		var newPlayer = player.instantiate()
		
		var tank_node = newPlayer.get_node("tank")
		tank_node.player = i + 1
		tank_node.setColor(global.playersColors[i])
		tank_node.battlefield = self
		
		get_node("players").add_child(newPlayer)
		tanks.push_back(tank_node)
	)
	
	for tank in tanks: #for ai
		tank.playersNodes = tanks
		
	musicManager.play_music(preload("res://Musics/Fight.mp3"))
	setup_intermission()
	for i in range(4): 
		global.playersData[i].state = global.playerStates.NOT_IN_GAME
	global.forEachPlayingPlayer(func(i):
		global.playersData[i].state = global.playerStates.IN_FIGHT
	)
	newRound()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused and pause_menu.visible:
			pause_menu.hide_menu()
		else:
			get_tree().paused = true
			pause_menu.show_menu()

func unpause_game() -> void:
	get_tree().paused = false

func _physics_process(delta):
	var alives = 0
	for i in range(4):
		if global.playersData[i].state == global.playerStates.IN_FIGHT:
			alives += 1
	
	if gameState == gameStates.IN_FIGHT:
		if alives < 2:
			var winner: int
			for tank in tanks:
				if global.playersData[tank.player-1].state == global.playerStates.IN_FIGHT:
					winner = tank.player
			go_to_intermission(winner)
			return
	
	if gameState == gameStates.INTERMISSION:
		for child in $intermissions.get_children():
			if child.finished == false:
				return
		newRound()
	
func newRound():
	gameState = gameStates.COUNTDOWN
	cursorManager.disableCursors()
	
	for child in $intermissions.get_children():
		child.hide()
	
	for tank in tanks:
		if global.playersData[tank.player-1].lives > 0:
			goToRandomPosition(tank.player)
			global.playersData[tank.player-1].state = global.playerStates.IN_FIGHT
			tank.show()
			
	$countdown.start_countdown(acceptBullet)

func goToRandomPosition(player: int):
	var randomPosition
	if spawns.size() == 1:
		randomPosition = spawns[0].get_random_point()
	else:
		randomPosition = spawns[player-1].get_random_point()
	
	var tank_node = 	func(): for i in range(tanks.size()):
				if  tanks[i].player == player:
					return tanks[i]
	tank_node.call().global_position = randomPosition

func go_to_intermission(winner):
	gameState = gameStates.INTERMISSION
	cursorManager.enableCursors()
	var stillAlive = 0
	for i in range(global.playersData.size()):
		if global.playersData[i].playerType != global.playerTypes.NONE:
			stillAlive += 1
	
	for tank in tanks:
		var player = tank.player
		deleteAllChildren(tank.get_parent().get_node("bullets"))
		if player == winner:
			continue
		
		global.playersData[tank.player-1].lives -= 1
		if global.playersData[tank.player-1].lives > 0:
			global.playersData[player-1].state = global.playerStates.SELECTING_UPGRADES
			tank.get_parent().show()
			for intermission in $intermissions.get_children():
				if intermission.player == tank.player:
					intermission.show()
		else:
			stillAlive -= 1
			tank.get_parent().hide()
			
	if stillAlive <= 1:		
		var winningScene = winningScreen.instantiate()
		get_tree().root.add_child(winningScene)
		winningScene.setup(winner)
		get_tree().current_scene.queue_free()
		get_tree().call_deferred("set_current_scene", winningScene)

func setup_intermission():
	var screen_size = get_viewport_rect().size
	var screen_width = get_viewport_rect().size.x
	global.forEachPlayingPlayer(func(i):
		var newIntermission = intermission.instantiate()
		newIntermission.set("player", i+1)
		newIntermission.hide()
		newIntermission.scale = Vector2(0.5, 0.5)
		newIntermission.position = Vector2(screen_size.x * int((i % 2) == 1)/2, screen_size.y * int(i > 1)/2 )
		get_node("intermissions").add_child(newIntermission)
	)

func getIntermissionPlayerNodeIfLost(intermission):
	for tank in tanks:
		if tank.player == intermission.player:
			if global.playersData[tank.player-1].lives <= 0:
				return tank
			else:
				return null
				

func deleteAllChildren(parentNode: Node):
	for child in parentNode.get_children():
		child.queue_free()

func acceptBullet():
	gameState = gameStates.IN_FIGHT
