extends VBoxContainer


func _on_fight_pressed() -> void:
	global.activePlayer = 4
	get_tree().change_scene_to_file("res://Game/Battlefield.tscn")

func _on_vs_1_pressed() -> void:
	global.activePlayer = 2
	get_tree().change_scene_to_file("res://Game/Battlefield.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
