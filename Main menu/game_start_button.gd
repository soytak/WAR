extends TextureButton

func _ready() -> void:
	position = (get_parent().get_size() - get_size()) / 2
	position.y += 100
