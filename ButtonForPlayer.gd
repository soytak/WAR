class_name ButtonForPlayer
extends Button

var player: int = -1
@export var alsoMouse: bool = false
signal onClick
signal onPressed

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and get_rect().has_point((event.position)) and visible:
		if event.pressed:
			if event.has_meta("player") and event.get_meta("player") == player:
				callAppropriateSignal(event)
			elif alsoMouse and not event.has_meta("player"):
				callAppropriateSignal(event)
				
func callAppropriateSignal(event: InputEventMouseButton):
	if event.pressed:
		onClick.emit(event)
	else:
		onPressed.emit(event)
