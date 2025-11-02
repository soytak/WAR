extends PanelContainer

var lastKeyInput: InputEventKey
var remapping: bool = false
signal remappingFinished

func rebind(action: global.actions, currentValue: StringName, update: Callable) -> void:
	%"rebind popup".show()
	%"previous value".text = tr("REBIND_POPUP3")+ " " + currentValue
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
	%status.text = tr("REBIND_POPUP2") + ": " + prettyString + " " + tr("REBIND_POPUP2B")
	%status.self_modulate = Color.RED

func markAsWaiting() -> StringName:
	%status.text = "REBIND_POPUP2"
	%status.self_modulate = Color.hex(0x3a3a3a)
	return "REBIND_POPUP2"

func _input(event: InputEvent) -> void:
	if not remapping: return
	if event is InputEventKey:
		lastKeyInput = event
		remapping = false
		emit_signal("remappingFinished")
		accept_event()
