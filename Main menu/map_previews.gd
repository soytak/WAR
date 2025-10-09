extends GridContainer

var mapSelected = null
var hueShift = 0

func _ready() -> void:
	var mapPrevSize = Vector2(1920, 1080) / 5
	
	for map in global.maps:
		var container = Container.new()
		var button = Button.new()
		button.modulate = Color.TRANSPARENT
		button.set_meta("map", map)
		
		if not button.pressed.is_connected(selectMap):
			button.pressed.connect(selectMap.bind(map))
		
		var control = Control.new()
		
		var mapNode = map.instantiate()
		mapNode.scale = mapPrevSize / Vector2(1920, 1080)
		control.add_child(mapNode)
		
		container.add_child(control)
		container.add_child(button)
		container.custom_minimum_size = mapPrevSize
		button.custom_minimum_size = mapPrevSize
		%"map previews".add_child(container)

func selectMap(map):
	mapSelected = map

func _process(delta: float) -> void:
	for child in %"map previews".get_children():
		var button = child.get_child(1)
		var buttonMap = button.get_meta("map")
		
		if buttonMap == mapSelected:
			button.modulate = Color.WHITE
		else:
			button.modulate = Color.TRANSPARENT
	
	hueShift += delta / 10
	%WAR.modulate = Color.from_hsv(fmod(hueShift, 1.0), 1.0, 1.0, 0.8)
	%ColorRect.modulate = Color.from_hsv(fmod(hueShift + 0.5, 1.0), 1.0, 1.0, 0.8)

func _on_war_pressed() -> void:
	var battlefield = preload("res://Game/Battlefield.tscn").instantiate()
	battlefield.setMap(mapSelected)
	get_tree().root.add_child(battlefield)
	get_tree().current_scene.queue_free()
	get_tree().call_deferred("set_current_scene", battlefield)
