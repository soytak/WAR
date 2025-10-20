extends PanelContainer

var lastKeyInput: InputEventKey
var remapping: bool = false
signal remapping_finished

func rebind(action: StringName, currentValue: StringName, update: Callable) -> void:
	%"rebind popup".show()
	%"previous value".text = "Currently set to: " + currentValue
	remapping = true
	
	await remapping_finished
	
	var actionName = 'P' + str(get_parent().currentPlayerTab) + ' ' + action.to_lower()
	if action.to_lower() == "pause": actionName = "pause"
	
	InputMap.action_erase_events(actionName)
	InputMap.action_add_event(actionName, lastKeyInput)
	update.call(lastKeyInput.as_text_key_label())
	%"rebind popup".hide()
	

func _input(event: InputEvent) -> void:
	if not remapping: return
	if event is InputEventKey:
		lastKeyInput = event
		remapping = false
		emit_signal("remapping_finished")
		accept_event()
