extends PanelContainer

var panelMessages = [
	"PANEL1",
	"PANEL2",
	"PANEL3",
	"PANEL4"
]

var panelMessageActive = 0
func _ready() -> void:
	hide()
	setPanelTo(panelMessageActive)

func _input(event: InputEvent) -> void:
	if not visible: return
	if event is InputEventKey:
		for i in range(4):
			if event.pressed and Input.is_action_pressed(global.getPlayerInput(i, "right")):
				panelMessageActive += 1
				setPanelTo(panelMessageActive)
				accept_event()
			if event.pressed and Input.is_action_pressed(global.getPlayerInput(i, "left")):
				panelMessageActive -= 1
				setPanelTo(panelMessageActive)
				accept_event()
				
	if event is InputEventMouseButton and event.pressed:
		hide()
		accept_event()
				
func setPanelTo(panelMessage: int):
	$MarginContainer/VBoxContainer/instruction.text = tr(panelMessages[panelMessage % panelMessages.size()])
