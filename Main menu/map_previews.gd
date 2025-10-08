extends GridContainer

func _ready() -> void:
	var mapPrevSize = Vector2(1920,1080) / 5
	
	for map in global.maps:
		var container = Container.new()
		var button = Button.new()
		button.modulate = Color.TRANSPARENT
		var control = Control.new()
		
		var mapNode = map.instantiate()
		mapNode.scale = mapPrevSize / Vector2(1920, 1080)
		control.add_child(mapNode)
		
		container.add_child(control)
		container.add_child(button)
		container.custom_minimum_size = mapPrevSize
		button.custom_minimum_size = mapPrevSize
		%"map previews".add_child(container)
