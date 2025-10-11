extends Node

var playerInput = [
	["up","down","left","right","kp0"],
	["w","s","a","d","leftShift"],
	["i","k","j","l",";"],
	["kp8","kp5","kp4","kp6","kp+"]
]
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
