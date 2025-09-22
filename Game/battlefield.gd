extends Node2D

var player = preload("res://Game/Player.tscn")
var intermission = preload("res://Game/intermission/intermission.tscn")
@onready var pause_menu = $pauseMenu
var tanks: Array = []
const playerNb: int = 4

func _ready() -> void:
	cursorManager.disableCursors()
	for i in range(playerNb):
		var newPlayer = player.instantiate()
		goToRandomPosition(newPlayer)
		
		var tank_node = newPlayer.get_node("tank")
		tank_node.player = i+1
		tank_node.setColor(global.playersColors[i])
		
		get_node("players").add_child(newPlayer)
		tanks.push_back(tank_node)
		
	musicManager.play_music(preload("res://Musics/Fight.mp3"))
	setup_intermission()
	for i in range(4):
		global.playersData[i].state = global.playerStates.IN_FIGHT

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
	for child in $players.get_children():
		if child.get_node("tank").visible:
			alives += 1
	if alives < 2:
		for child in $players.get_children():
			if child.get_node("tank").visible:
				pass
				go_to_intermission(child.get_node("tank").player)
	
	for child in $intermissions.get_children():
		if child.finished == false or alives > 1:
			return
	newRound()
	
func newRound():
	cursorManager.disableCursors()
	for child in $players.get_children():
		goToRandomPosition(child)
		child.get_node("tank").show()
	$intermissions.hide()

func goToRandomPosition(player: Node2D):
	var viewport_size = get_viewport().size
	var random_x = randi_range(0, int(viewport_size.x))
	var random_y = randi_range(0, int(viewport_size.y))
	var random_position = Vector2(random_x, random_y)
	
	var tank_node = player.get_node("tank")
	tank_node.global_position = random_position

func go_to_intermission(winner):
	cursorManager.enableCursors()
	$intermissions.show()
	var player = 0
	for child in $intermissions.get_children():
		player += 1
		if player != winner:
			global.playersData[player-1].state = global.playerStates.SELECTING_UPGRADES
			child.show()
		else:
			global.playersData[player-1].state = global.playerStates.DEAD

func setup_intermission():
	var screen_size = get_viewport_rect().size
	var screen_width = get_viewport_rect().size.x
	for i in range(playerNb):
		var newIntermission = intermission.instantiate()
		newIntermission.set("player", i+1)
		newIntermission.hide()
		newIntermission.scale = Vector2(0.5, 0.5)
		newIntermission.position = Vector2(screen_size.x * int((i % 2) == 1)/2, screen_size.y * int(i > 1)/2 )
		get_node("intermissions").add_child(newIntermission)
