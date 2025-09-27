extends Control

var player = 0
var finished: bool = true

var upgrade_botton = preload("res://Game/intermission/Upgrade_button.tscn")

func _ready() -> void:
	for upgrade in global.upgrades:
		var newUgrade_button = upgrade_botton.instantiate()
		newUgrade_button.texture_normal = load(upgrade.texturePath)
		newUgrade_button.dispName = upgrade.dispName
		newUgrade_button.onClick.connect(onUpgradeSelect)
		%UpgradeContainer.add_child(newUgrade_button)

func onUpgradeSelect(dispName: StringName):
	for upgrade in global.upgrades:
		if upgrade.dispName == dispName:
			global.playersData[player-1].upgradesState[upgrade.internalName] = true
			%Right.hide()
			finished = true
			break


func _on_visibility_changed() -> void:
	if visible:
		%Lives.text = "Lives: " + str(global.playersData[player-1].lives)
		%Right.show()
		finished = false
	else:
		finished = true
