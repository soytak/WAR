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
	
	var nbOfSameInput: int = global.getNbOfSameInput(lastKeyInput.as_text())
	var isInputSame: bool = currentValue == global.getActionsPrettyString(lastKeyInput.as_text())

	if nbOfSameInput - int(isInputSame) >= 1:
		markAsAlreadyTaken(lastKeyInput.as_text())
		rebind(action, currentValue, update)
		return
	finishRebind(actionName, update)

	
func finishRebind(actionName: StringName, update: Callable) -> void:
	InputMap.action_erase_events(actionName)
	InputMap.action_add_event(actionName, lastKeyInput)
	var text = lastKeyInput.as_text_key_label()
	update.call(text)
	%"rebind popup".hide()
	markAsWaiting()
	
func markAsAlreadyTaken(string: StringName) -> void:
	var prettyString = global.getActionsPrettyString(string)
	%status.text = "waiting input: " + prettyString + " is already took"
	%status.self_modulate = Color.RED
func markAsWaiting() -> StringName:
	%status.text = "waiting input"
	%status.self_modulate = Color.hex(0x3a3a3a)
	return "waiting input"

func _input(event: InputEvent) -> void:
	if not remapping: return
	if event is InputEventKey:
		lastKeyInput = event
		remapping = false
		emit_signal("remappingFinished")
		accept_event()
