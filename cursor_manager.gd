extends CanvasLayer

var cursora = preload("res://cursor.tscn")
var MinAFKTime: float = 5
var MinAFKTimeEnable: bool = false
var CursorSensibility: float = 10

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

func getPressedPlayer() -> int:
	for child in $Control.get_children():
		if child.pressed:
			return child.player
	return -1

func getCursorPressed(player: int) -> bool:
	for child in $Control.get_children():
		if child.player == player:
			return child.pressed
	return false

func changeCursorSensibility(sensibility: float):
	CursorSensibility = clampf(CursorSensibility+sensibility, 6, 20)
	for child in $Control.get_children():
		child.speed = CursorSensibility
