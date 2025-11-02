extends MarginContainer

@export var action: global.actions
signal remap

func _ready() -> void:
	match action:
		global.actions.UP:
			%action.text = tr("UP")
			%"secondairy name".text = tr("/FORWARD")
		global.actions.DOWN:
			%action.text = tr("DOWN")
			%"secondairy name".text = tr("/BACKWARD")
		global.actions.LEFT:
			%action.text = tr("LEFT")
			%"secondairy name".text = tr("/TURN")
		global.actions.RIGHT:
			%action.text = tr("RIGHT")
			%"secondairy name".text = tr("/TURN")
		global.actions.PRIMARYBUTTON:
			%action.text = tr("SELECT")
			%"secondairy name".text = tr("/SHOOT")
		global.actions.ESC:
			%action.text = tr("PAUSE")
			%"secondairy name".text = ""
			

func setValue(value: StringName):
	%value.text = global.getActionsPrettyString(value)
	
func update(player: int):
	var actionName = global.actionDisplayToInput(action, player)
	
	var events = InputMap.action_get_events(actionName)
	if events.size() <= 0: return
	if events[0] is InputEventKey:
		var key_event := events[0] as InputEventKey
		var string = key_event.as_text()
		setValue(string)


func _on_button_pressed() -> void:
	remap.emit(action, %value.text, setValue)
	setValue("___")
	pass
