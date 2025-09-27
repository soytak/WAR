extends PanelContainer

var panelMessages = [
	"Welcome to WAR
	Controls:
	Use the mouse to navigate menu
	Player 1: arrows for movement and 0 (of keypad) or right control to shoot
	Player 2: wasd for movement and shift to shoot
	Player 3: ijkl for movement and ; to shoot
	Player 4: 8456 for movement and + to shoot (keypad)
	",
	"Goal: Be the last one standing each round
	Round: Use your tank to eliminate the others.
	When only one player is alive, it is time for the intermission!
	\nIntermission:
	If nobody exept one has no health, the one who still got life wins.
	In intermission, deads with lives left can select an upgrade.
	",
	"This game has audio.\nHave a good time!"
]

var panelMessageActive = 0
func _ready() -> void:
	hide()
	setPanelTo(panelMessageActive)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		for i in range(4):
			if event.pressed and Input.is_action_pressed(global.getPlayerInput(i, "right")):
				panelMessageActive += 1
				setPanelTo(panelMessageActive)
			if event.pressed and Input.is_action_pressed(global.getPlayerInput(i, "left")):
				panelMessageActive -= 1
				setPanelTo(panelMessageActive)
			if event.pressed and Input.is_action_pressed(global.getPlayerInput(i, "shoot")):
				hide()
				
func setPanelTo(panelMessage: int):
	$VBoxContainer/instruction.text = panelMessages[panelMessage % panelMessages.size()]
