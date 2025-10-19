extends MarginContainer

@export var player: int = 1
signal onClick

func _ready() -> void:
	$PlayerTab.text = "P" + str(player).to_upper()



func _on_player_tab_pressed() -> void:
	onClick.emit(player)
