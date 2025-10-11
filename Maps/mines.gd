extends CharacterBody2D

var goingUp: bool = true
var speed: int = 10000
var move_velocity: float = 0

func _ready() -> void:
	switchSide()
	position = Vector2(get_viewport_rect().size.x / 2 + $sprite.texture.get_size().x / 4.5, 0)

func _physics_process(delta: float) -> void:
	if goingUp:
		move_velocity = -speed
	else:
		move_velocity = speed

	velocity = Vector2(0, move_velocity) * delta
	move_and_slide()

func switchSide():
	goingUp = not goingUp
	if goingUp:
		$Area2D/up.disabled = false
		$Area2D/down.disabled = true
	else:
		$Area2D/up.disabled = true
		$Area2D/down.disabled = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Collision with end of rail detected!")
	switchSide()
