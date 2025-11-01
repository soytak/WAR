extends MarginContainer

enum actions {UP, DOWN, LEFT, RIGHT, PRIMARYBUTTON, ESC}

@export var action: actions
signal remap

func _ready() -> void:
	match action:
		actions.UP:
			%action.text = tr("UP")
			%"secondairy name".text = tr("/FORWARD")
		actions.DOWN:
			%action.text = tr("DOWN")
			%"secondairy name".text = tr("/BACKWARD")
		actions.LEFT:
			%action.text = tr("LEFT")
			%"secondairy name".text = tr("/TURN")
		actions.RIGHT:
			%action.text = tr("RIGHT")
			%"secondairy name".text = tr("/TURN")
		actions.PRIMARYBUTTON:
			%action.text = tr("SELECT")
			%"secondairy name".text = tr("/SHOOT")
		actions.ESC:
			%action.text = tr("PAUSE")
			%"secondairy name".text = ""
			

func setValue(value: StringName):
	%value.text = global.getActionsPrettyString(value)
	
func update(player: int):
	var actionName = global.actionDisplayToInput(%action.text, player)
	
	var events = InputMap.action_get_events(actionName)
	if events.size() <= 0: return
	if events[0] is InputEventKey:
		var key_event := events[0] as InputEventKey
		var string = key_event.as_text()
		setValue(string)


func _on_button_pressed() -> void:
	remap.emit(%action.text, %value.text, setValue)
	setValue("___")
	pass
