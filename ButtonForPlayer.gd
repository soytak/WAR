class_name ButtonForPlayer
extends Button

var player: int = -1
@export var alsoMouse: bool = false
@export var anyPlayer: bool = false
@export var getBackEvent: bool = false
signal onClick

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and get_rect().has_point((event.position)) and visible:
		if event.has_meta("player") and (event.get_meta("player") == player or anyPlayer):
			callRightSignal(event)
		elif alsoMouse and not event.has_meta("player"):
			callRightSignal(event)

func callRightSignal(event: InputEventMouseButton) -> void:
	if getBackEvent:
		onClick.emit(event)
	else:
		onClick.emit()
