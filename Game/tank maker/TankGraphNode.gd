extends MarginContainer

var evolutionId
var helded: bool = false
var heldPosition: Vector2

func setTo(evolutionId: int) -> void:
	self.evolutionId = evolutionId
	$MarginContainer/VBoxContainer/CenterContainer/Control/TankMaker.make(evolutionId)
	%Name.text = evolutionManager.getEvolutionIdName(evolutionId)
	var children = evolutionManager.getNextEvolutionsID(evolutionId)
	var parents = evolutionManager.getAllParents(evolutionId)
	var gotChild = children.size() >= 1
	var gotParent = parents.size() >= 1
	
func _ready() -> void:
	$ButtonForPlayer.onClick.connect(click)
	
func click(event: InputEventMouse):
	position = event.global_position
	heldPosition = event.global_position
