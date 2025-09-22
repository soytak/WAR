extends Resource
class_name Upgrade

@export var dispName: String
@export var texturePath: String
@export var texture: Resource
@export var internalName: String

static func create(dispName: String, texturePath: String, internalName: String) -> Upgrade:
	var instance = Upgrade.new()
	instance.dispName = dispName
	instance.texturePath = texturePath
	instance.texture = load(texturePath)
	instance.internalName = internalName
	return instance
