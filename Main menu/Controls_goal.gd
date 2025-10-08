extends PanelContainer

var panelMessages = [
	"Welcome to WAR
	Controls:
	Use the mouse to navigate menu
	Player 1: arrows for movement and 0 (of keypad) or right control to shoot
	Player 2: wasd for movement and shift (or space) to shoot
	Player 3: ijkl for movement and ; to shoot
	Player 4: 8456 for movement and + to shoot (keypad)
	",
	"Goal: Be the last one standing each round
	Round: Use your tank to eliminate the others.
	When only one player is alive, it is time for the intermission!
	\nIntermission:
	If nobody exept one has no health, the one who still got life wins.
	In intermission, deads with lives left can select an upgrade,
	and more importantly: an evolution.
	Evolutions are tree based, so the previous choice matters as well.
	",
	"This game has audio.\n
	Be aware that bots are in very early state
	Have a good time!"
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
	$VBoxContainer/instruction.text = panelMessages[panelMessage % panelMessages.size()]
