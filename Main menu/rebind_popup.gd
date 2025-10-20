extends PanelContainer

var lastKeyInput: StringName = "NONE"

func rebind(action: StringName):
	%"rebind popup".show()

	await lastKeyInput != "NONE"
	var events = InputMap.action_get_events(action)[0]
	InputMap.action_erase_events(lastKeyInput)
	#InputMap.action_add_event(lastKeyInput, event)
	lastKeyInput = "NONE"
	
func _input(event: InputEvent) -> void:
	if lastKeyInput == "NONE": return
	if event is InputEventKey:
		lastKeyInput = event.as_text_key_label()
		accept_event()
