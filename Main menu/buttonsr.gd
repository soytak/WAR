extends VBoxContainer


func _on_fight_pressed() -> void:
	get_tree().change_scene_to_file("res://Main menu/PlayerSelect.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
