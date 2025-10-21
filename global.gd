extends Node

var playerInput = [
	["P1 up","P1 down","P1 left","P1 right","P1 enter"],
	["P2 up","P2 down","P2 left","P2 right","P2 enter"],
	["P3 up","P3 down","P3 left","P3 right","P3 enter"],
	["P4 up","P4 down","P4 left","P4 right","P4 enter"]
]

var actionInputDisplay: Dictionary = {
	"up": "Up",
	"down": "Down",
	"left": "Left",
	"right": "Right",
	"enter": "Select",
	"pause": "Pause"
}

func actionInputToDisplay(string: StringName) -> String:
	string = getActionsPrettyString(string)
	string = actionInputDisplay[string]
	return string

func actionDisplayToInput(string: StringName, player: int) -> String:
	print(string)
	string = invertDictionary(actionInputDisplay)[string]
	#string = actionInputDisplay.invert()[string]
	if string == "pause": return string
	string = 'P' + str(player) + ' ' + string
	return string

func getActionsPrettyString(string: StringName) -> StringName:
	
	var playerPrefixRule : RegEx = RegEx.new()
	playerPrefixRule.compile("P[1-4]")
	string = playerPrefixRule.sub(string, "", true)
	
	string = string.replace('_', ' ')
	string = string.replace("Kp", "keypad")
	
	return string
	
func invertDictionary(original: Dictionary) -> Dictionary:
	var result: Dictionary = {}
	for key in original:
		result[original[key]] = key
	return result


var playersColors = [
	Color.CYAN,
	Color.ORANGE,
	Color.GREEN,
	Color.PURPLE
]

enum playerStates {NOT_IN_GAME, IN_FIGHT, DEAD, SELECTING_UPGRADES}
enum playerTypes {NONE, PLAYER, BOT}

var upgrades: Array[Upgrade] = [
	Upgrade.create("Bigger bullets", "res://Textures/bigger_bullets.png", "biggerBullets"),
	Upgrade.create("Faster bullets", "res://Textures/faster_bullets.png", "fasterBullets"),
	Upgrade.create("Less shot cooldown", "res://Textures/less_cooldown.png", "lessCooldown"),
	Upgrade.create("Smaller tank", "res://Textures/smaller_tank.png", "smallerTank"),
	Upgrade.create("Faster tank", "res://Textures/faster_tank.png", "fasterTank"),
	Upgrade.create("Faster tank rotation", "res://Textures/faster_tank_rotation.png", "fasterTankRotation"),
	Upgrade.create("Makes upgrade stats better", "res://Textures/upgrade_upgrades.png", "upgradeUpgrades"),
]

var maps = [preload("res://Maps/river.tscn"),
			preload("res://Maps/food_cooking.tscn"),
			preload("res://Maps/volcano.tscn"),
			preload("res://Maps/tower.tscn"),
			preload("res://Maps/sacred_bird.tscn"),
			preload("res://Maps/mines.tscn")
		   ]


var playersData: Array[PlayerData] = []

func forEachPlayingPlayer(function: Callable):
	for i in range(4):
		if playersData[i].playerType == playerTypes.NONE:
			continue
		if function.is_valid():
			function.call(i)
		else:
			push_error("Invalid function passed to call_with_arg.")

func _ready() -> void:
	InputMap.load_from_project_settings()
	SaveManager.loadSettings()
	for i in range(4):
		var data := PlayerData.create(upgrades)
		data.state = playerStates.NOT_IN_GAME
		playersData.append(data)

func getPlayerInput(n: int, action: StringName):
	var inputs = getPlayerInputs(n)
	return getInputFromInputs(inputs, action)

func getPlayerInputs(n: int):
	return playerInput[n-1]
	
func getInputFromInputs(inputs: Array, action: StringName):
	match action:
		"foward":
			return inputs[0]
		"backward":
			return inputs[1]
		"left":
			return inputs[2]
		"right":
			return inputs[3]
		"shoot":
			return inputs[4]
