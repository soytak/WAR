extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 2.5
@export var reload = 1
@export var player = 1

var rotation_direction = 0
var reload_timer = reload
var bullet = preload("res://Game/Bullet.tscn")
@onready var inputs = global.getPlayerInputs(player)

func _ready() -> void:
	set_hue(0.4)
	
func set_hue(shift_amount):
	$"sprite".modulate = Color.from_hsv(shift_amount, 0, 1)
		
func get_input():
	rotation_direction = Input.get_axis(global.getInputFromInputs(inputs, "left"), global.getInputFromInputs(inputs, "right"))
	velocity = transform.x * Input.get_axis(global.getInputFromInputs(inputs, "backward"), global.getInputFromInputs(inputs, "foward")) * speed
	if Input.is_action_pressed(global.getInputFromInputs(inputs, "shoot")) and reload_timer <= 0:
		spawn_bullet()

func spawn_bullet():
	reload_timer = reload
	var new_bullet = bullet.instantiate()
	new_bullet.playerNode = self
	new_bullet.global_position = global_position
	new_bullet.global_rotation = global_rotation
	new_bullet.setColor($sprite.self_modulate)
	if global.playersData[player-1].upgradesState.biggerBullets:
		new_bullet.scale += Vector2(0.5 + upgradeUpgraded(0.2), 0.5 + upgradeUpgraded(0.2))
	if global.playersData[player-1].upgradesState.fasterBullets:
		new_bullet.speed += 300 + upgradeUpgraded(100)
	$"../bullets".add_child(new_bullet)

func _physics_process(delta):
	if not visible:
		return
	if global.playersData[player-1].upgradesState.smallerTank:
		$sprite.scale = Vector2(0.075 - upgradeUpgraded(0.01), 0.075 - upgradeUpgraded(0.01))
	if global.playersData[player-1].upgradesState.lessCooldown:
		reload = 0.8 - upgradeUpgraded(0.1)
	if global.playersData[player-1].upgradesState.fasterTank:
		speed = 550 + upgradeUpgraded(50)
	if global.playersData[player-1].upgradesState.fasterTankRotation:
		rotation_speed = 3.5 + upgradeUpgraded(0.5)

	reload_timer -= delta
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bulletHurtbox"):
		var bullet_node = area.get_parent()
		if bullet_node.playerNode != self:
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			global.playersData[player-1].state = global.playerStates.DEAD
			hide()

func setColor(color: Color) -> void:
	$sprite.self_modulate = color
	


func _on_visibility_changed() -> void:
	if visible:
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func upgradeUpgraded(nb: float = 1) -> float:
	return nb * int(global.playersData[player-1].upgradesState.upgradeUpgrades)
