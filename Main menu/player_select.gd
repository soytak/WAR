extends Control

const individualPlayerSelect = preload("res://Main menu/individual player select.tscn")
var hueShift: float = 0

func _ready() -> void:
	for i in range(4):
		var newButton = individualPlayerSelect.instantiate()
		newButton.size = Vector2(1920/2, 1080/2)
		newButton.player = i+1
		newButton.self_modulate = global.playersColors[i]
		
		$GridContainer.add_child(newButton)

func _process(delta: float) -> void:
	if getActivePlayer() > 1:
		$"Game Start Button".show()
	else:
		$"Game Start Button".hide()
		
	hueShift += delta/10
	$"Game Start Button".modulate = Color.from_hsv(fmod(hueShift, 1.0), 1.0, 1.0, 0.8)
	$ColorRect.modulate = Color.from_hsv(fmod(hueShift+0.5, 1.0), 1.0, 1.0, 0.8)

func getActivePlayer() ->int:
	var activePlayer = 0
	for i in range(4):
		if global.playersData[i].playerType != global.playerTypes.NONE:
			activePlayer += 1
	return activePlayer

func _on_game_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Battlefield.tscn")
