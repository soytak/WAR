extends CanvasLayer

var cursora = preload("res://cursor.tscn")
var MinAFKTime: float = 5
var MinAFKTimeEnable: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in range(4):
		var newCursor = cursora.instantiate()
		newCursor.enable()
		newCursor.player = i+1
		$Control.add_child(newCursor)

func disableCursors():
	for child in $Control.get_children():
		child.disable()

func enableCursors():
	for child in $Control.get_children():
		child.enable()

func getCursorPosition(player: int) -> Vector2:
	for child in $Control.get_children():
		if child.player == player:
			return child.position
	return Vector2.ZERO
