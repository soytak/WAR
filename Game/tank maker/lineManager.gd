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

	var my_canvas_xform := get_global_transform_with_canvas()

	for card in cards_parent.get_children():
		if not card.has_method("get_parent_card"):
			continue

		var parent = card.get_parent_card()
		if parent == null:
			continue

		var from_canvas_center: Vector2
		var to_canvas_center: Vector2

		var half_card_size  = Vector2.ZERO
		var half_parent_size = Vector2.ZERO

		half_card_size = %Cards.scale * card.size * card.scale * 0.5
		half_parent_size = %Cards.scale * parent.size * parent.scale * 0.5

		from_canvas_center = card.get_global_transform_with_canvas() * Vector2.ONE + half_card_size
		to_canvas_center   = parent.get_global_transform_with_canvas() * Vector2.ONE + half_parent_size

		var local_from = my_canvas_xform.affine_inverse() * from_canvas_center
		var local_to   = my_canvas_xform.affine_inverse() * to_canvas_center

		draw_line(local_from, local_to, Color(1, 1, 1, 0.9), 3.0, true)
