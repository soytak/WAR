extends Node2D

var player = preload("res://Game/Player.tscn")
var intermission = preload("res://Game/intermission/intermission.tscn")
@onready var pause_menu = $pauseMenu
var tanks: Array = []
const playerNb: int = 4

var players_colors = [
	Color.WHITE,
	Color.BLUE,
	Color.GREEN,
	Color.RED
]

func _ready() -> void:
	var viewport_size = get_viewport().size
	for i in range(playerNb):
		var newPlayer = player.instantiate()
		var random_x = randi_range(0, int(viewport_size.x))
		var random_y = randi_range(0, int(viewport_size.y))
		var random_position = Vector2(random_x, random_y)
		
		var tank_node = newPlayer.get_node("tank")
		tank_node.global_position = random_position
		tank_node.player = i+1
		
		tank_node.setColor(players_colors[i])
		
		get_node("players").add_child(newPlayer)
		tanks.push_back(tank_node)
	musicManager.play_music(preload("res://Musics/Fight.mp3"))
	setup_intermission()

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
				#go_to_intermission(child.get_node("tank").player)
		
func setup_intermission():
	var screen_size = get_viewport_rect().size
	var screen_width = get_viewport_rect().size.x
	for i in range(playerNb):
		var newIntermission = intermission.instantiate()
		newIntermission.set("player", i+1)
		newIntermission.hide()
		newIntermission.position = Vector2(0,0)
		get_node("intermissions").add_child(newIntermission)

func go_to_intermission(winner):
	var player = 0
	for child in $intermissions.get_children():
		player += 1
		if player != winner:
			child.show()
	pass
