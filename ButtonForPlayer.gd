class_name ButtonForPlayer
extends Button

var player: int = -1
var alsoMouse: bool = false
signal onClick

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and get_rect().has_point(get_local_mouse_position()):
		print("be one")
		if event.has_meta("player") and event.get_meta("player") == player:
			print("be gone")
			onClick.emit()
		elif alsoMouse:
			print("be gone")
			onClick.emit()
				#accept_event()
