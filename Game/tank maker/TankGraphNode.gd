extends MarginContainer

var evolutionId
var helded: bool = false
var heldedEvent: InputEventMouseButton
var heldPosition: Vector2

func setTo(evolutionId: int) -> void:
	self.evolutionId = evolutionId
	$MarginContainer/VBoxContainer/CenterContainer/Control/TankMaker.make(evolutionId)
	%Name.text = evolutionManager.getEvolutionIdName(evolutionId)
	var children = evolutionManager.getNextEvolutionsID(evolutionId)
	var parents = evolutionManager.getAllParents(evolutionId)
	var gotChild = children.size() >= 1
	var gotParent = parents.size() >= 1
	
func _ready() -> void:
	$ButtonForPlayer.onClick.connect(click)
	
func click(event: InputEventMouse):
	heldedEvent = event
	helded = true
	heldPosition = event.global_position - position

func _process(delta: float) -> void:
	if helded:
		if not heldedEvent.has_meta("player"):
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				position += (get_viewport().get_mouse_position() - heldPosition - position) / 5
			else:
				helded = false
		else:
			var cursorPlayer = heldedEvent.get_meta("player")
			if Input.is_action_pressed(global.getPlayerInput(cursorPlayer,"shoot")):
				var cursorPosition = cursorManager.getCursorPosition(cursorPlayer)
				position += (cursorPosition - heldPosition - position) / 5
			else:
				helded = false
