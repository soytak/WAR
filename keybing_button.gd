extends MarginContainer

enum actions {UP, DOWN, LEFT, RIGHT, PRIMARYBUTTON, ESC}

@export var action: actions
signal remap

func _ready() -> void:
	match action:
		actions.UP:
			%action.text = "Up"
			%"secondairy name".text = "/Forward"
		actions.DOWN:
			%action.text = "Down"
			%"secondairy name".text = "/Backward"
		actions.LEFT:
			%action.text = "Left"
			%"secondairy name".text = "/Turn"
		actions.RIGHT:
			%action.text = "Right"
			%"secondairy name".text = "/Turn"
		actions.PRIMARYBUTTON:
			%action.text = "Select"
			%"secondairy name".text = "/Shoot"
		actions.ESC:
			%action.text = "Pause"
			%"secondairy name".text = ""
			

func setValue(value: StringName):
	%value.text = global.getActionsPrettyString(value)
	
func update(player: int):
	var actionName = global.actionDisplayToInput(%action.text, player)
	
	var events = InputMap.action_get_events(actionName)
	if events[0] is InputEventKey:
		var key_event := events[0] as InputEventKey
		var string = key_event.as_text()
		setValue(string)


func _on_button_pressed() -> void:
	remap.emit(%action.text, %value.text, setValue)
	setValue("___")
	pass
