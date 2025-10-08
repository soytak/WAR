extends Node2D

var canonTexture = preload("res://Textures/tank/canon.png")

const DEFANGLE = 0
const DEFDISTANCE = 35
const DEFXOFFSET = 0
const DEFSCALE = Vector2.ONE
const DEFSPEEDSCALAR = 1

var cooldownScalar = 1

func _ready() -> void:
	pass
	
func getBaseSize() -> Vector2:
	return $base.texture.get_size() * $base.scale
	
func make(evolutionID: int):
	cooldownScalar = 1
	for child in %canons.get_children():
		child.free()
	for child in $decoration.get_children():
		child.free()
	var e = evolutionManager.evolutionsID
	match evolutionID:
		e.BASIC:
			createCanon()
		e.UPGRADEDBASIC:
			createCanon(0, 35, 0, Vector2.ONE, 1.1)
			cooldownScalar = 0.9
		e.DOUBLESHOT:
			createCanon(DEFANGLE, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 0.8)
			createCanon(0, 35, 0, Vector2(0.4, 0.4))
		e.MACHINEGUN:
			createTurretDecoration(evolutionManager.decorationsID.MACHINEGUN)
			createCanon(0, 35, 0, Vector2(1, 0.9))
			cooldownScalar = 0.7
		e.LANDMINE:
			pass
		e.BIG:
			createCanon(0, 35, 0, Vector2(1, 1.5))
		e.DOUBLEGUN:
			createCanon(0, 35, -15)
			createCanon(0, 35,  15)
		e.SNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.3)
		e.DUAL:
			createCanon()
			createCanon(180)
		e.THREEWAY:
			createCanon(45)
			createCanon(-45)
			createCanon()
			
		#machine gun
		e.UPGRADEDMACHINEGUN:
			createTurretDecoration(evolutionManager.decorationsID.UPGRADEDMACHINEGUN)
			createCanon(0, 35, 0, Vector2(1, 0.9))
			cooldownScalar = 0.5
		e.SMALLSPRINKLERONMACHINEGUN:
			createTurretDecoration(evolutionManager.decorationsID.HALFSPRINKLER)
			createCanon(0, 35, 0, Vector2(1, 0.9))
			cooldownScalar = 0.5
		e.SPRINKLER:
			createTurretDecoration(evolutionManager.decorationsID.SPRINKLE)
			cooldownScalar = 0.2
			
		#big
		e.UPGRADEDBIG:
			createCanon(0, 35, 0, Vector2(1.2, 2.2))
		e.UPGRADEDBIGTWOWAY:
			createCanon(45)
			createCanon(-45)
			createCanon(0, 35, 0, Vector2(1.2, 2.2))
		#quaternary big
			
		#double gun
		e.FOURGUN:
			createCanon(0, 35, -15)
			createCanon(0, 35,  15)
			createCanon(180, 35, -15)
			createCanon(180, 35,  15)
		e.SIXGUN:
			createCanon(0, 35, -15)
			createCanon(0, 35,  15)
			createCanon(90+45, 35, -15)
			createCanon(90+45, 35,  15)
			createCanon(-90-45, 35, -15)
			createCanon(-90-45, 35,  15)
		#octal
		
		#sniper
		e.TSNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.4)
			createCanon(90)
			createCanon(-90)
		e.FOURWAYSNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.4)
			createCanon(90)
			createCanon(-90)
			createCanon(180, DEFDISTANCE, DEFXOFFSET, Vector2(1, 1.5))
		e.TYSNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.4)
			createCanon(90)
			createCanon(-90)
			createCanon(90+60)
			createCanon(-90-60)
		e.YSNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.4)
			createCanon(90+45)
			createCanon(-90-45)
		e.UPGRADEDYSNIPER:
			createCanon(0, 35, 0, Vector2(1.6, 0.7), 1.8)
			createCanon(90+45)
			createCanon(-90-45)
		e.VYSNIPER:
			createCanon(0, 35, 0, Vector2(1.4, 0.7), 1.4)
			createCanon(90+45)
			createCanon(-90-45)
			createCanon(180)
			
		#dual
		e.QUATERNARY:
			createCanon()
			createCanon(180)
			createCanon(90)
			createCanon(-90)
		e.OCTAL:
			createCanon()
			createCanon(180)
			createCanon(90)
			createCanon(-90)
			createCanon(45)
			createCanon(-45)
			createCanon(90+45)
			createCanon(-90-45)
		e.BIGQUATERNARY:
			createCanon(DEFANGLE, DEFDISTANCE, DEFXOFFSET, Vector2(1,2.2))
			createCanon(180, DEFDISTANCE, DEFXOFFSET, Vector2(1,2.2))
			createCanon(90, DEFDISTANCE, DEFXOFFSET, Vector2(1,2.2))
			createCanon(-90, DEFDISTANCE, DEFXOFFSET, Vector2(1,2.2))
		
		#threeway
		e.FIVEWAY:
			createCanon(50)
			createCanon(-50)
			createCanon(25)
			createCanon(-25)
			createCanon()
		e.SIXWAY:
			createCanon(60)
			createCanon(-60)
			createCanon(40)
			createCanon(-40)
			createCanon(20)
			createCanon(-20)
			
		#doubleshot
		e.TRIPLESHOT:
			createCanon(DEFANGLE, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 0.6)
			createCanon(0, 35, 0, Vector2(0.6, 0.6), 0.8)
			createCanon(0, 35, 0, Vector2(0.3, 0.3))
		e.QUADRIPLESHOT:
			createCanon(DEFANGLE, DEFDISTANCE, DEFXOFFSET,  Vector2(1.4, 1.4), 0.6)
			createCanon(DEFANGLE, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 0.8)
			createCanon(0, 35, 0, Vector2(0.6, 0.6), 1)
			createCanon(0, 35, 0, Vector2(0.3, 0.3), 1.2)
		e.VDOUBLESHOT:
			createCanon(45, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 0.8)
			createCanon(45, DEFDISTANCE, DEFXOFFSET, Vector2(0.4, 0.4))
			createCanon(-45, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 0.8)
			createCanon(-45, DEFDISTANCE, DEFXOFFSET, Vector2(0.4, 0.4))
			
		#UPGRADEDBASIC
		e.UPGRADEDUPGRADEDBASIC:
			createCanon(0, 35, 0, Vector2.ONE * 1.1, 1.2)
			cooldownScalar = 0.8
		e.UPGRADEDUPGRADEDUPGRADEDBASIC:
			createCanon(0, 35, 0, Vector2.ONE * 1.2, 1.3)
			cooldownScalar = 0.7
			
		e.BACKWARDSHOT:
			createCanon(180, 35, 0, Vector2.ONE * 1.1, 1.2)
			cooldownScalar = 0.8
		e.BACKWARDSHOTSNIPER:
			createCanon(180, 35, 0, Vector2(1.6, 0.6), 2)
			cooldownScalar = 0.8
		e.BACKWARDSIXWAY:
			const rev = 180
			createCanon(60+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			createCanon(-60+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			createCanon(40+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			createCanon(-40+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			createCanon(20+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			createCanon(-20+rev, DEFDISTANCE, DEFXOFFSET, DEFSCALE, 1.2)
			cooldownScalar = 0.8
		
		e.DROPPER:
			createCanon(0, 35, 0, Vector2.ONE, 0.4)
			cooldownScalar = 0.9
		e.UPGRADEDDROPPER:
			createCanon(0, 35, 0, Vector2.ONE, 0.3)
			cooldownScalar = 0.8
		e.LANDMINEONDROPPER:
			createCanon(0, 35, 0, Vector2.ONE, 0)
			createCanon(0, 35, 0, Vector2.ONE, 0.4)
			cooldownScalar = 0.9
			
func createCanon(
angleDeg: int = DEFANGLE, distance: int = DEFDISTANCE, xOffset: int = DEFXOFFSET,
scale: Vector2 = DEFSCALE, speedScalar: float = DEFSPEEDSCALAR):
	var angle = deg_to_rad(angleDeg)
	var canon = Sprite2D.new()
	canon.texture = canonTexture
	canon.scale = Vector2.ONE * 0.3
	canon.rotation = angle

	canon.position = Vector2(cos(angle), sin(angle)) * distance

	if xOffset != 0:
		angle += deg_to_rad(90)
		canon.position += Vector2(cos(angle), sin(angle)) * xOffset

	canon.scale *= scale
	#additionnal info
	canon.set_meta("speedScalar", speedScalar)
	%canons.add_child(canon)

func getCanons() -> Array[Sprite2D]:
	var canons: Array[Sprite2D] = []
	for canon in $%canons.get_children():
		canons.append(canon)
	return canons

func createTurretDecoration(decorationID: int):
	var ressource = load(evolutionManager.getDecorationTexturePath(decorationID))
	var newDecoration = Sprite2D.new()
	newDecoration.texture = ressource
	$decoration.add_child(newDecoration)
