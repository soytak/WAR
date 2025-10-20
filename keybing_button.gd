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

func update(value: StringName):
	%value.text = global.getActionsPrettyString(value)
	pass


func _on_button_pressed() -> void:
	var actionName = %action.text
	if actionName == "Select": actionName = "enter"
	remap.emit(actionName, %value.text, update)
	update("___")
	pass
