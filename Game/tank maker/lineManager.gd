extends Control

@onready var cards_parent: Node = %Cards

func _ready() -> void:
	set_process(true)
	queue_redraw()

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if cards_parent == null:
		return

	for card in cards_parent.get_children():
		if not card.has_method("get_parent_card"):
			continue

		var parent = card.get_parent_card()
		if parent == null:
			continue

		var from_global = card.global_position + (card.size * card.scale) / 2.0
		var to_global = parent.global_position + (parent.size * parent.scale) / 2.0

		var local_from = get_global_transform_with_canvas().affine_inverse() * from_global
		var local_to = get_global_transform_with_canvas().affine_inverse() * to_global

		draw_line(local_from, local_to, Color(1, 1, 1, 0.9), 3.0, true)
