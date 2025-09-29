extends Resource
class_name PlayerData

@export var evolutionID: int = evolutionManager.evolutionsID.BASIC
@export var state: int = 0
@export var upgradesState := {}
@export var lives: int = 0

static func create(upgrades: Array[Upgrade]) -> PlayerData:
	var instance = PlayerData.new()
	instance.evolutionID = evolutionManager.evolutionsID.BASIC
	instance.lives = 5
	for upgrade in upgrades:
		instance.upgradesState[upgrade.internalName] = false
	return instance

static func reset(player: PlayerData) -> void:
	player.evolutionID = evolutionManager.evolutionsID.BASIC
	player.lives = 5
	for key in player.upgradesState.keys():
		player.upgradesState[key] = false
