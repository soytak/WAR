class_name TextureButtonForPlayer
extends TextureButton

var player: int = -1
@export var alsoMouse: bool = false
signal onClick

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and visible:
		var size = get_rect()
		size.position = Vector2(0,0)
		if not size.has_point((event.position)):
			return
		if event.has_meta("player") and event.get_meta("player") == player:
			onClick.emit()
		elif alsoMouse and not event.has_meta("player"):
			onClick.emit()
