extends Node2D

var speed = 500
var playerNode = Node

func _ready():
	pass
	
func _physics_process(delta):
	var direction = transform.x.normalized()
	var move_vec = direction * speed
	global_position += move_vec * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("deadzone"):
		queue_free()
	if area.is_in_group("playerHitbox"):
		var char_node = area.get_parent()
		if char_node != playerNode:
			queue_free()

func setColor(color: Color) -> void:
	$sprite.self_modulate = color
