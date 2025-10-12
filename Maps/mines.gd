extends CharacterBody2D

var goingUp: bool = true
var speed: int = 10000

func _ready() -> void:
	switchSide()
	position = Vector2(get_viewport_rect().size.x / 2 + $sprite.texture.get_size().x / 4.5, 0)

func _physics_process(delta: float) -> void:
	var yVel: float = 0
	if goingUp:
		yVel = -speed
	else:
		yVel = speed

	velocity = Vector2(0, yVel) * delta
	move_and_slide()

func switchSide():
	goingUp = not goingUp
	if goingUp:
		$Area2D/up.disabled = false
		$Area2D/down.disabled = true
	else:
		$Area2D/up.disabled = true
		$Area2D/down.disabled = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("deadzone") or area.is_in_group("bulletHurtbox"): return
	_on_area_2d_body_entered(area)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self: return
	print("Collision with end of rail detected!" + body.name)
	switchSide.call_deferred()
