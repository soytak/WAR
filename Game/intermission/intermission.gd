extends Control

var player = 0
var finished: bool = true
var evolutionChoiceMade: bool = false
var upgradeChoiceMade: bool = false

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
			upgradeChoiceMade = true
			break

func _process(delta: float) -> void:
	if evolutionChoiceMade && upgradeChoiceMade:
		finished = true

func _on_visibility_changed() -> void:
	if visible:
		for child in %Evolutions.get_children():
			child.free()
		
		var nextEvolutionsID = evolutionManager.getNextEvolutionsID(global.playersData[player-1].evolutionID)
		for evolutionID in nextEvolutionsID:
			var newTankPreview = preload("res://Game/tank maker/tank maker.tscn").instantiate()
			newTankPreview.make(evolutionID)
			var newCountainer = CenterContainer.new()
			var newControl = Control.new()
			var newButton = Button.new()
			newButton.self_modulate = Color.TRANSPARENT
			newButton.custom_minimum_size = Vector2(Vector2.ONE * 200)
			
			if not newButton.pressed.is_connected(tankSelect):
				newButton.pressed.connect(tankSelect.bind(evolutionID))
			
			newTankPreview.modulate = global.playersColors[player-1]
			newCountainer.custom_minimum_size = Vector2(Vector2.ONE * 200)
			
			newTankPreview.scale = Vector2.ONE * 2
			
			newControl.add_child(newTankPreview)
			newCountainer.add_child(newControl)
			newCountainer.add_child(newButton)
			%Evolutions.add_child(newCountainer)
		
		%Lives.text = "Lives: " + str(global.playersData[player-1].lives)
		%Right.show()
		%Left.show()
		upgradeChoiceMade = false
		evolutionChoiceMade = false
		finished = false


func tankSelect(evolutionID: int):
	global.playersData[player-1].evolutionID = evolutionID
	evolutionChoiceMade = true
	%Left.hide()
