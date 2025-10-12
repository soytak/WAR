extends Button

func _ready() -> void:
	position = (get_parent().get_size() - get_size()) / 2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if get_rect().has_point(event.position):
			pressed.emit()
			accept_event()
