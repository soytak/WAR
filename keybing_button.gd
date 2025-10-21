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
	pass
	
func update(player: int):
	var actionName = global.actionDisplayToInput(%action.text, player)
	%value.text = (InputMap.action_get_events(actionName)[0] as InputEventKey).as_text_key_label()
	


func _on_button_pressed() -> void:
	remap.emit(%action.text, %value.text, setValue)
	setValue("___")
	pass
