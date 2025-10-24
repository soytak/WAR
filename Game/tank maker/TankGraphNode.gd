extends GraphNode

var evolutionId

func setTo(evolutionId: int) -> void:
	self.evolutionId = evolutionId
	$GraphFrame/Control/TankMaker.make(evolutionId)
	title = evolutionManager.getEvolutionIdName(evolutionId)
	var children = evolutionManager.getNextEvolutionsID(evolutionId)
	var parents = evolutionManager.getAllParents(evolutionId)
	var gotChild = children.size() >= 1
	var gotParent = parents.size() >= 1
	set_slot_enabled_left(0,gotParent)
	set_slot_enabled_right(0,gotChild)
	

func setConnections(connectAll: Callable):
	var children = evolutionManager.getNextEvolutionsID(evolutionId)
	for child in children:
		connectAll.call(evolutionId, child)
