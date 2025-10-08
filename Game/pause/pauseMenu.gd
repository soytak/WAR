extends Control

@onready var unpause_button = $Panel/VBoxContainer/unpause
@onready var exit_button = $Panel/VBoxContainer/exit
@onready var dim_rect = $bg

var mainMenu = preload("res://Main menu/Menu.tscn")

var hue_shift : float = 0.0

func _ready() -> void:
	hide()
	exit_button.modulate = Color.RED
	dim_rect.color = Color(0, 0, 0, 0)

func show_menu() -> void:
	show()
	var screen_size = get_viewport_rect().size
	var screen_width = get_viewport_rect().size.x
	position = Vector2(-size.x/2, screen_size.y / 2 - size.y / 2)
	var tween = create_tween()
	tween.tween_property(self, "position:x", screen_width/2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(dim_rect, "color:a", 0.5, 0.5)
	tween.finished.connect(func():
		get_tree().paused = true
		cursorManager.enableCursors()
	)

func hide_menu() -> void:
	var screen_width = get_viewport_rect().size.x
	var tween = create_tween()
	tween.tween_property(self, "position:x", -screen_width, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(dim_rect, "color:a", 0.0, 0.5)
	tween.finished.connect(func ():
		hide()
		cursorManager.disableCursors()
		get_parent().unpause_game()
	)



func _process(delta: float) -> void:
	if visible:
		hue_shift += delta
		unpause_button.modulate = Color.from_hsv(fmod(hue_shift, 1.0), 1.0, 1.0)

func _on_unpause_button_pressed() -> void:
	hide_menu()

func _on_exit_button_pressed() -> void:
	get_parent().unpause_game()
	get_tree().change_scene_to_packed(mainMenu)
