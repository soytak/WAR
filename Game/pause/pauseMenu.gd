extends CanvasLayer

@onready var unpause_button = $Control/Panel/VBoxContainer/unpause
@onready var exit_button = $Control/Panel/VBoxContainer/exit
@onready var dim_rect = $bg
@onready var control = $Control
@export var hidingCursor: bool = false

var mainMenu = preload("res://Main menu/Menu.tscn")

var hue_shift : float = 0.0

func _ready() -> void:
	hide()
	exit_button.modulate = Color.RED
	#dim_rect.color = Color(0, 0, 0, 0)

func show_menu() -> void:
	show()
	get_tree().paused = true
	var screen_size = control.get_viewport_rect().size
	var screen_width = control.get_viewport_rect().size.x
	control.position = Vector2(-control.size.x, screen_size.y / 2 - control.size.y / 2)
	var tween = create_tween()
	tween.tween_property(control, "position:x", 0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween.parallel().tween_property(dim_rect, "color:a", 0.5, 0.5)
	tween.finished.connect(func():
		cursorManager.enableCursors()
	)

func hide_menu() -> void:
	var screen_width = control.get_viewport_rect().size.x
	var tween = create_tween()
	tween.tween_property(control, "position:x", -screen_width, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#tween.parallel().tween_property(dim_rect, "color:a", 0.0, 0.5)
	tween.finished.connect(func ():
		hide()
		if hidingCursor: cursorManager.disableCursors()
		get_tree().paused = false
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused and visible:
			hide_menu()
		else:
			show_menu()

func _process(delta: float) -> void:
	if visible:
		
		hue_shift += delta
		unpause_button.modulate = Color.from_hsv(fmod(hue_shift, 1.0), 1.0, 1.0)

func _on_unpause_pressed() -> void:
	hide_menu()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(mainMenu)


func _on_settings_pressed() -> void:
	%Settings.activate()
