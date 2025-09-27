extends Resource
class_name PlayerData

@export var evolutionId: int = 0
@export var state: int = 0
@export var upgradesState := {}
@export var lives: int = 0

static func create(upgrades: Array[Upgrade]) -> PlayerData:
	var instance = PlayerData.new()
	instance.lives = 5
	for upgrade in upgrades:
		instance.upgradesState[upgrade.internalName] = false
	return instance

static func reset(player: PlayerData) -> void:
	player.lives = 5
	for key in player.upgradesState.keys():
		player.upgradesState[key] = false
