extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 2.5
@export var reload = 1
@export var player = 1

var color: Color = Color.WHITE
var rotation_direction = 0
var reload_timer = reload
var bullet = preload("res://Game/Bullet.tscn")
@onready var inputs = global.getPlayerInputs(player)
var maker

func _ready() -> void:
	maker = %TankMaker
	updateSprite()
		
func get_input():
	rotation_direction = Input.get_axis(global.getInputFromInputs(inputs, "left"), global.getInputFromInputs(inputs, "right"))
	velocity = transform.x * Input.get_axis(global.getInputFromInputs(inputs, "backward"), global.getInputFromInputs(inputs, "foward")) * speed
	if Input.is_action_pressed(global.getInputFromInputs(inputs, "shoot")) and reload_timer <= 0:
		spawn_bullet()

func spawn_bullet():
	reload_timer = reload * maker.cooldownScalar
	var canons = maker.getCanons()
	
	for canon in canons:
		var new_bullet = bullet.instantiate()
		#commun settings
		new_bullet.playerNode = self
		new_bullet.setColor(maker.modulate)
		#canon settings
		new_bullet.rotation = canon.rotation + rotation
		new_bullet.global_position = canon.global_position
		new_bullet.speed *= canon.get_meta("speedScalar")
		new_bullet.scale *= canon.scale/0.3
		#upgrade
		if global.playersData[player-1].upgradesState.biggerBullets:
			new_bullet.scale += Vector2(0.5 + upgradeUpgraded(0.2), 0.5 + upgradeUpgraded(0.2))
		if global.playersData[player-1].upgradesState.fasterBullets:
			new_bullet.speed += 300 + upgradeUpgraded(100)
		$"../bullets".add_child(new_bullet)

func _physics_process(delta):
	if not visible:
		return
	
	if global.playersData[player-1].upgradesState.smallerTank:
		maker.scale = Vector2(0.8 - upgradeUpgraded(0.1), 0.8 - upgradeUpgraded(0.1))
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

func setColor(targetedColor: Color) -> void:
	color = targetedColor

func _on_visibility_changed() -> void:
	if visible:
		updateSprite()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func upgradeUpgraded(nb: float = 1) -> float:
	return nb * int(global.playersData[player-1].upgradesState.upgradeUpgrades)

func updateSprite():
	%TankMaker.make(global.playersData[player-1].evolutionID)
	%TankMaker.modulate = color
