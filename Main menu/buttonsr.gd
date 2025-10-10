extends VBoxContainer


func _on_fight_pressed() -> void:
	TransitionManager.setColor(Color.AQUA)
	TransitionManager.playTransition(goToPlayerSelect, 1)

func goToPlayerSelect():
	get_tree().change_scene_to_file("res://Main menu/PlayerSelect.tscn")

func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_settings_pressed() -> void:
	%Settings.activate()
