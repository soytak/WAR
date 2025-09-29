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
	
func make(evolutionID: int):
	cooldownScalar = 1
	for child in %canons.get_children():
		child.free()
	var e = evolutionManager.evolutionsID
	match evolutionID:
		e.BASIC:
			createCanon()
		e.UPGRADEDBASIC:
			createCanon(0, 35, 0, Vector2.ONE, 1.1)
			cooldownScalar = 0.9
		e.DOUBLESHOT:
			createCanon()
			createCanon(0, 35, 0, Vector2(0.4, 0.4), 0.8)
		e.MACHINEGUN:
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
			createCanon()
			createCanon(45)
			createCanon(-45)
		#machine gun
		e.UPGRADEDMACHINEGUN:
			createCanon(0, 35, 0, Vector2(1, 0.9))
			cooldownScalar = 0.5
		#big
		e.UPGRADEDBIG:
			createCanon(0, 35, 0, Vector2(1.2, 2.2))
		#e.UPGRADEDBIGTWOWAY:
			#createCanon(0, 35, 0, Vector2(1.2, 2.2))
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
