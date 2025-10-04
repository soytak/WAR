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
var playersNodes
var battlefield

func _ready() -> void:
	maker = %TankMaker
	updateSprite()
		
func get_input():
	rotation_direction = Input.get_axis(global.getInputFromInputs(inputs, "left"), global.getInputFromInputs(inputs, "right"))
	velocity = transform.x * Input.get_axis(global.getInputFromInputs(inputs, "backward"), global.getInputFromInputs(inputs, "foward")) * speed
	if Input.is_action_pressed(global.getInputFromInputs(inputs, "shoot")):
		tryToShoot()
		
func get_ai_input():
	var closestDistance = 10000
	var closestPlayer
	for tank in playersNodes:
		if tank.visible == false: continue
		if tank == self: continue
		var dist = global_position.distance_to(tank.global_position)
		if closestDistance > dist:
			closestDistance = dist
			closestPlayer = tank
	
	if closestDistance == 10000:
		return
			
	const farDistance = 500
	const lowDistance = 200
	const enemyBulletAngularAcceptence = 20
	const angularAcceptence = deg_to_rad(3)
	var rotationDiff = wrapf(get_angle_to(closestPlayer.position), -PI, PI)
	var rotationDiffInverse = wrapf(get_angle_to(closestPlayer.position) + PI, -PI, PI)
	
	velocity = Vector2.ZERO
	var front = filterOwnBullets($front.get_overlapping_areas()).size() > 0
	var back = filterOwnBullets($back.get_overlapping_areas()).size() > 0
	var left = filterOwnBullets($"left side".get_overlapping_areas()).size() > 0
	var right = filterOwnBullets($"right side".get_overlapping_areas()).size() > 0
	
	var doQuit: bool = false
	
		
	if front:
		velocity = -Vector2.ONE * speed * transform.x
		tryToShoot()
		return
		
	if back:
		for bullet in filterOwnBullets($back.get_overlapping_areas()):
			var offAngle = bullet.rotation - (get_angle_to(bullet.position) + deg_to_rad(180))
			if abs(offAngle) < enemyBulletAngularAcceptence:
				doQuit = true
				velocity = Vector2.ONE * speed * transform.x
				break
			
	if left != right: #xor
		doQuit = true
		rotation_direction = int(left) - int(right)
		velocity = Vector2.ONE * speed * transform.x
	
	if doQuit:
		tryToShoot()
		return
		
	if closestDistance > farDistance:
		if abs(rotationDiff) < deg_to_rad(5):
			velocity = Vector2.ONE * speed * transform.x
	if closestDistance > lowDistance:
		if rotationDiff > angularAcceptence:
			rotation_direction = 1
		elif rotationDiff < -angularAcceptence:
			rotation_direction = -1
		else: #good rotation
			rotation_direction = 0
			tryToShoot()
	if closestDistance < lowDistance:
		velocity = Vector2.ONE * speed * transform.x
		tryToShoot()
		if rotationDiffInverse < rotationDiff:
			if rotationDiffInverse > angularAcceptence:
				rotation_direction = 1
			elif rotationDiffInverse < -angularAcceptence:
				rotation_direction = -1
		else:
			if rotationDiff > angularAcceptence:
				rotation_direction = -1
			elif rotationDiff < -angularAcceptence:
				rotation_direction = 1
		

func tryToShoot():
	if reload_timer <= 0 and battlefield.gameState == battlefield.gameStates.IN_FIGHT:
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
	
	if global.playersData[player-1].evolutionID in [evolutionManager.evolutionsID.SPRINKLER, evolutionManager.evolutionsID.SMALLSPRINKLERONMACHINEGUN]:
		var new_bullet = bullet.instantiate()
		#commun settings
		new_bullet.playerNode = self
		new_bullet.setColor(maker.modulate)
		
		new_bullet.rotation = randf_range(0, 360)
		new_bullet.global_position = global_position
		
		if global.playersData[player-1].upgradesState.biggerBullets:
			new_bullet.scale += Vector2(0.5 + upgradeUpgraded(0.2), 0.5 + upgradeUpgraded(0.2))
		if global.playersData[player-1].upgradesState.fasterBullets:
			new_bullet.speed += 300 + upgradeUpgraded(100)
		$"../bullets".add_child(new_bullet)
		
func filterOwnBullets(array):
	var newArray: Array = []
	for element in array:
		var node = element.get_parent()
		if "playerNode" in node:
			if node.playerNode != self:
				newArray.append(node)
	return newArray

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
	if global.playersData[player-1].playerType == global.playerTypes.PLAYER:
		get_input()
	else:
		get_ai_input()
		#debug_overlaps()
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

func debug_overlaps():
	var front_areas = $front.get_overlapping_areas()
	print("--- FRONT overlaps: areas=", front_areas.size())
	for a in front_areas:
		print(" area:", a, "class:", a.get_class(), "name:", a.name)

	# same for left / right
	var la = $"left side".get_overlapping_areas()
	print("LEFT: areas=", la.size())
	var ra = $"right side".get_overlapping_areas()
	print("RIGHT: areas=", ra.size())
