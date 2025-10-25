extends Control

var nodesRef: Dictionary[int,MarginContainer]
var currentEvolutionId: int = 0
@onready var preview = %TankMaker
var maker = preload("res://Game/tank maker/tank maker.tscn")

func _ready() -> void:
	updateName()
	setupGraph()

func updateName():
	var name = evolutionManager.getEvolutionIdName(currentEvolutionId)
	%"Tank name".text = name
	preview.make(currentEvolutionId)
	preview.position = Vector2(0,0)
	preview.scale = Vector2.ONE * 2
	
	var nextEvolutions = evolutionManager.getNextEvolutionsID(currentEvolutionId)
	var previousEvolutions = evolutionManager.getAllParents(currentEvolutionId)
	
	for child in %"Next upgrades".get_children():
		child.free()
	for child in %"Previous upgrades".get_children():
		child.free()
	
	for evolution in nextEvolutions:
		var newContainer = CenterContainer.new()
		var newButton = Button.new()
		newButton.self_modulate = Color.TRANSPARENT
		newButton.custom_minimum_size = Vector2.ONE * 100
		var newControl = Control.new()
		
		var newTankPreview = maker.instantiate()
		newTankPreview.make(evolution)
		
		if not newButton.pressed.is_connected(tankSelect):
			newButton.pressed.connect(tankSelect.bind(evolution))
		
		newContainer.custom_minimum_size = Vector2.ONE * 100
		newTankPreview.scale = Vector2.ONE
		
		newControl.add_child(newTankPreview)
		newContainer.add_child(newControl)
		newContainer.add_child(newButton)
		%"Next upgrades".add_child(newContainer)
	
	for evolution in previousEvolutions:
		var newContainer = CenterContainer.new()
		var newButton = Button.new()
		newButton.self_modulate = Color.TRANSPARENT
		newButton.custom_minimum_size = Vector2.ONE * 100
		var newControl = Control.new()
		
		var newTankPreview = maker.instantiate()
		newTankPreview.make(evolution)
		
		if not newButton.pressed.is_connected(tankSelect):
			newButton.pressed.connect(tankSelect.bind(evolution))
		
		newContainer.custom_minimum_size = Vector2.ONE * 100
		newTankPreview.scale = Vector2.ONE
		
		newControl.add_child(newTankPreview)
		newContainer.add_child(newControl)
		newContainer.add_child(newButton)
		%"Previous upgrades".add_child(newContainer)
		
	if nextEvolutions.size() == 0:
		var newLabel = Label.new()
		newLabel.text = "Death"
		newLabel.theme = preload("res://Main menu/text.tres")
		%"Next upgrades".add_child(newLabel)
		
	if previousEvolutions.size() == 0:
		var newLabel = Label.new()
		newLabel.text = "None"
		newLabel.theme = preload("res://Main menu/text.tres")
		%"Previous upgrades".add_child(newLabel)
		

func _on_previous_pressed() -> void:
	changeCurrentEvolutionId(-1)


func _on_next_pressed() -> void:
	changeCurrentEvolutionId(1)

func changeCurrentEvolutionId(change: int, setting: bool = false):
	if setting:
		currentEvolutionId = change % evolutionManager.evolutionsID.size()
	else:
		currentEvolutionId = (currentEvolutionId+change) % evolutionManager.evolutionsID.size()
	if currentEvolutionId < 0:
		currentEvolutionId = evolutionManager.evolutionsID.size()-1
	updateName()


func _on_exit_pressed() -> void:
	$".".hide()

func tankSelect(evolutionId: int):
	currentEvolutionId = evolutionId
	updateName()


func setupGraph():
	nodesRef.clear()
	var node = preload("res://Game/tank maker/tankNode.tscn")
	for evolutionId in evolutionManager.getNextEvolutionsID(0):
		var newNode = node.instantiate()
		newNode.setTo(evolutionId)
		$SubViewportContainer/SubViewport.add_child(newNode)
		nodesRef[evolutionId] = newNode
