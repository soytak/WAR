extends Control

var nodesRef: Dictionary[int,MarginContainer]
var currentEvolutionId: int = 0
@onready var preview = %TankMaker
const EvolutionCards = preload("res://Game/tank maker/tankNode.tscn")
var maker = preload("res://Game/tank maker/tank maker.tscn")
var graphMode: bool = true
var targetZoom: float = 1
var zoom: float = 1
var graphTranslation: Vector2 = Vector2.ZERO
var currentSlidePlayer: int = -2
var slideStart: Vector2 = Vector2.ZERO


func _ready() -> void:
	updateName()
	setupGraph()
	
func switchMode() -> void:
	graphMode = not graphMode
	
func _process(delta: float) -> void:
	zoom += (targetZoom - zoom)/6
	%Cards.scale = Vector2.ONE * zoom
	%LineManager.scale = Vector2.ONE * zoom
	
	%Cards.position = graphTranslation
	%LineManager.position = graphTranslation
	
	if graphMode:
		$Graph.show()
	else:
		$Graph.hide()
		
		
	if currentSlidePlayer >= 1:
		if cursorManager.getCursorPressed(currentSlidePlayer):
			var curPosition: Vector2 = cursorManager.getCursorPosition(currentSlidePlayer)
			var diffPosition: Vector2 = curPosition - slideStart
			
			graphTranslation += diffPosition
			slideStart = curPosition
		else:
			currentSlidePlayer = -1

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
	%Cards.position = Vector2(%viewport.size/2)
	%Cards.pivot_offset = Vector2(%viewport.size/2)
	%LineManager.pivot_offset = Vector2(%viewport.size/2)
	var newNode = Control.new()
	var pos = Vector2(%viewport.size/2)
	setupCard(pos, 0, 0, [0], null)


func setupNextEvolutionsOf(evolutionParent: Control, dir: float) -> void:
	var nextEvolutions: Array = evolutionManager.getNextEvolutionsID(evolutionParent.evolutionId)
	var i: int = 0
	for evolutionId in nextEvolutions:
		var angleRange = 70
		const dist = 500
		if nextEvolutions.size() == 1: angleRange = 0
		if nextEvolutions.size() == 8: angleRange = 360
		var angleOfMovement = dir + deg_to_rad(angleRange/nextEvolutions.size()*i - angleRange/2)
		var Offset = Vector2(cos(angleOfMovement), sin(angleOfMovement)) * dist
		
		setupCard(evolutionParent.position+Offset, i, angleOfMovement, nextEvolutions, evolutionParent)
		i+=1

func setupCard(offset: Vector2, i: int, dir: float, nextEvolutions: Array, parent: Control):
	var newNode = EvolutionCards.instantiate()
	newNode.scale = Vector2.ONE * 0.2
	
	newNode.setTo(nextEvolutions[i], parent)
	newNode.position = offset - newNode.size*newNode.scale/2

	%Cards.add_child(newNode)
	nodesRef[nextEvolutions[i]] = newNode
	setupNextEvolutionsOf(newNode, dir)


func zoomOut() -> void:
	changeZoom(-0.1)

func zoomIn() -> void:
	changeZoom(0.1)

func changeZoom(zoomAmount: float) -> void:
	targetZoom = clampf(targetZoom+zoomAmount, 0.4, 1.8)


func detectSlide() -> void:
	currentSlidePlayer = cursorManager.getPressedPlayer()
	slideStart = cursorManager.getCursorPosition(currentSlidePlayer)
