extends Resource
class_name PlayerData

@export var evolutionId: int = 0
@export var state: int = 0
@export var upgradesState := {}

static func create(upgrades: Array[Upgrade]) -> PlayerData:
	var instance = PlayerData.new()
	for upgrade in upgrades:
		instance.upgradesState[upgrade.internalName] = false
	return instance
