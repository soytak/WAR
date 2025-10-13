extends Control

var currentEvolutionId: int = 0
@onready var preview = %TankMaker
var maker = preload("res://Game/tank maker/tank maker.tscn")

func _ready() -> void:
	updateName()

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
		var newControl = Control.new()
		var newMaker = maker.instantiate()
		newMaker.make(evolution)
		newControl.add_child(newMaker)
		%"Next upgrades".add_child(newControl)
	
	for evolution in previousEvolutions:
		var newControl = Control.new()
		var newMaker = maker.instantiate()
		newMaker.make(evolution)
		newControl.add_child(newMaker)
		%"Previous upgrades".add_child(newControl)
		
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
