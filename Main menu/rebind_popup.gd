extends PanelContainer

var lastKeyInput: InputEventKey
var remapping: bool = false
signal remappingFinished

func rebind(action: StringName, currentValue: StringName, update: Callable) -> void:
	%"rebind popup".show()
	%"previous value".text = "Currently set to: " + currentValue
	remapping = true
	
	await remappingFinished
	
	var actionName = global.actionDisplayToInput(action, get_parent().currentPlayerTab)
	
	InputMap.action_erase_events(actionName)
	InputMap.action_add_event(actionName, lastKeyInput)
	var text = lastKeyInput.as_text_key_label()
	update.call(text)
	%"rebind popup".hide()
	

func _input(event: InputEvent) -> void:
	if not remapping: return
	if event is InputEventKey:
		lastKeyInput = event
		remapping = false
		emit_signal("remappingFinished")
		accept_event()
