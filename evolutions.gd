extends Node

enum decorationsID {
	MACHINEGUN,
	UPGRADEDMACHINEGUN,
	SPRINKLE,
	HALFSPRINKLER,
}
func getDecorationTexturePath(decorationID: int):
	match decorationID:
		decorationsID.MACHINEGUN:
			return "res://Textures/tank/decorations/machine_gun_decoration.png"
		decorationsID.UPGRADEDMACHINEGUN:
			return "res://Textures/tank/decorations/upgraded_machine_gun_decoration.png"
		decorationsID.SPRINKLE:
			return "res://Textures/tank/decorations/sprinkler_decoration.png"
		decorationsID.HALFSPRINKLER:
			return "res://Textures/tank/decorations/halfsprinkler_decoration.png"

enum evolutionsID {BASIC,
DOUBLEGUN, SNIPER, THREEWAY, DOUBLESHOT, DUAL, BIG, UPGRADEDBASIC, MACHINEGUN, #LANDMINE,
#############################             ################################################

#DOUBLESHOT
TRIPLESHOT, #1
QUADRIPLESHOT, VDOUBLESHOT,




#done UPGRADEDBASIC
UPGRADEDUPGRADEDBASIC,#1
UPGRADEDUPGRADEDUPGRADEDBASIC, #RNG, #SPRINKLER
BACKWARDSHOT, #2
BACKWARDSHOTSNIPER, BACKWARDSIXWAY,
DROPPER, #3
UPGRADEDDROPPER, LANDMINEONDROPPER,
#tank who's bullets bounce, one who's bullets wraps around the screen


#done sniper
TSNIPER,#1
TYSNIPER, FOURWAYSNIPER,
YSNIPER,#2
UPGRADEDYSNIPER, VYSNIPER, #SIXGUN #TYSNIPER BACKWARDSHOTSNIPER

#done doublegun
FOURGUN,#1
SIXGUN,#OCTAL
#UPGRADEDMACHINEGUN #2

UPGRADEDMACHINEGUN,#1
SMALLSPRINKLERONMACHINEGUN,SPRINKLER,

#done dual
QUATERNARY,
BIGQUATERNARY,OCTAL,

#THREEWAY
FIVEWAY,#1
SIXWAY, #FOURWAYSNIPER BACKWARDSIXWAY

#big done
UPGRADEDBIG,
UPGRADEDBIGTWOWAY,#BIGQUATERNARY

##landmine done
#LANDMINEFACTORY,#1
#GRAVITATIONNALLANDMINEFACTORY,UPGRADEDLANDMINEFACTORY,
#LANDMINEWITHCANON,#2
#LANDMINEWITHTHREEWAYCANON,LANDMINEWITHDOUBLEMINECANON, #LANDMINEONDROPPER
}

func getEvolutionIdName(id):
	match id:
		evolutionsID.BASIC:
			return tr("T_BASIC")
		evolutionsID.DOUBLEGUN:
			return tr("T_DOUBLE_GUN")
		evolutionsID.SNIPER:
			return tr("T_SNIPER")
		evolutionsID.THREEWAY:
			return tr("T_THREE_WAY")
		evolutionsID.DOUBLESHOT:
			return tr("T_DOUBLE_SHOT")
		evolutionsID.DUAL:
			return tr("T_DUAL")
		evolutionsID.BIG:
			return tr("T_BIG")
		evolutionsID.UPGRADEDBASIC:
			return tr("T_UPGRADED_BASIC")
		evolutionsID.MACHINEGUN:
			return tr("T_MACHINE_GUN")
		#evolutionsID.LANDMINE:
			#return "Landmine"
		evolutionsID.TRIPLESHOT:
			return tr("T_TRIPLE_SHOT")
		evolutionsID.QUADRIPLESHOT:
			return tr("T_QUADRIPLE_SHOT")
		evolutionsID.VDOUBLESHOT:
			return tr("T_V_DOUBLE_SHOT")
		evolutionsID.UPGRADEDUPGRADEDBASIC:
			return tr("T_UPGRADED_UPGRADED_BASIC")
		evolutionsID.UPGRADEDUPGRADEDUPGRADEDBASIC:
			return tr("T_UPGRADED_UPGRADED_UPGRADED_BASIC")
		#evolutionsID.RNG:
			#return "RNG"
		evolutionsID.BACKWARDSHOT:
			return tr("T_BACKWARD_SHOT")
		evolutionsID.BACKWARDSHOTSNIPER:
			return tr("T_BACKWARD_SHOT_SNIPER")
		evolutionsID.BACKWARDSIXWAY:
			return tr("T_BACKWARD_SIX_WAY")
		evolutionsID.DROPPER:
			return tr("T_DROPPER")
		evolutionsID.UPGRADEDDROPPER:
			return tr("T_UPGRADED_DROPPER")
		evolutionsID.LANDMINEONDROPPER:
			return tr("T_LANDMINE_ON_DROPPER")
		evolutionsID.TSNIPER:
			return tr("T_T_SNIPER")
		evolutionsID.TYSNIPER:
			return tr("T_TY_SNIPER")
		evolutionsID.FOURWAYSNIPER:
			return tr("T_FOUR_WAY_SNIPER")
		evolutionsID.YSNIPER:
			return tr("T_Y_SNIPER")
		evolutionsID.UPGRADEDYSNIPER:
			return tr("T_UPGRADED_Y_SNIPER")
		evolutionsID.VYSNIPER:
			return tr("T_VY_SNIPER")
		evolutionsID.FOURGUN:
			return tr("T_FOUR_GUN")
		evolutionsID.SIXGUN:
			return tr("T_SIX_GUN")
		evolutionsID.SMALLSPRINKLERONMACHINEGUN:
			return tr("T_SMALL_SPRINKLER_ON_MACHINE_GUN")
		evolutionsID.SPRINKLER:
			return tr("T_SPRINKLER")
		evolutionsID.QUATERNARY:
			return tr("T_QUATERNARY")
		evolutionsID.BIGQUATERNARY:
			return tr("T_BIG_QUATERNARY")
		evolutionsID.OCTAL:
			return tr("T_OCTAL")
		evolutionsID.FIVEWAY:
			return tr("T_FIVE_WAY")
		evolutionsID.SIXWAY:
			return tr("T_SIX_WAY")
		evolutionsID.UPGRADEDMACHINEGUN:
			return tr("T_UPGRADED_MACHINE_GUN")
		evolutionsID.UPGRADEDBIG:
			return tr("T_UPGRADED_BIG")
		evolutionsID.UPGRADEDBIGTWOWAY:
			return tr("T_UPGRADED_BIG_TWO_WAY")
		#evolutionsID.LANDMINEFACTORY:
			#return "Landmine factory"
		#evolutionsID.GRAVITATIONNALLANDMINEFACTORY:
			#return "Gravitationnal landmine factory"
		#evolutionsID.UPGRADEDLANDMINEFACTORY:
			#return "Upgraded landmine factory"
		#evolutionsID.LANDMINEWITHCANON:
			#return "Landmine with canon"
		#evolutionsID.LANDMINEWITHTHREEWAYCANON:
			#return "Landmine with three way canon"
		#evolutionsID.LANDMINEWITHDOUBLEMINECANON:
			#return "Landmine with double mine canon"

var evolutionTree = {
	evolutionsID.BASIC: {

		evolutionsID.UPGRADEDBASIC: {
			evolutionsID.UPGRADEDUPGRADEDBASIC: [
				evolutionsID.UPGRADEDUPGRADEDUPGRADEDBASIC,
				#evolutionsID.RNG,
				evolutionsID.SPRINKLER,
			],
			evolutionsID.BACKWARDSHOT: [
				evolutionsID.BACKWARDSHOTSNIPER,
				evolutionsID.BACKWARDSIXWAY,
			],
			evolutionsID.DROPPER: [
				evolutionsID.UPGRADEDDROPPER,
				evolutionsID.LANDMINEONDROPPER,
			],
		},
		evolutionsID.DOUBLESHOT: {
			evolutionsID.TRIPLESHOT: [
				evolutionsID.QUADRIPLESHOT,
				evolutionsID.VDOUBLESHOT,
			]
		},
		evolutionsID.MACHINEGUN: {
			evolutionsID.UPGRADEDMACHINEGUN: [
				evolutionsID.SMALLSPRINKLERONMACHINEGUN,
				evolutionsID.SPRINKLER,
			]
		},
		
		#evolutionsID.LANDMINE: {
			#evolutionsID.LANDMINEFACTORY: [
				#evolutionsID.GRAVITATIONNALLANDMINEFACTORY,
				#evolutionsID.UPGRADEDLANDMINEFACTORY,
			#],
			#evolutionsID.LANDMINEWITHCANON: [
				#evolutionsID.LANDMINEWITHTHREEWAYCANON,
				#evolutionsID.LANDMINEWITHDOUBLEMINECANON,
			#]
		#},
		
		evolutionsID.BIG: {
			evolutionsID.UPGRADEDBIG: [
				evolutionsID.UPGRADEDBIGTWOWAY,
				evolutionsID.BIGQUATERNARY,
			]
		},
		
		evolutionsID.DOUBLEGUN: {
			evolutionsID.FOURGUN: [
				evolutionsID.SIXGUN,
				evolutionsID.OCTAL,
			],
			evolutionsID.UPGRADEDMACHINEGUN: [ #copy and pasted
				evolutionsID.SMALLSPRINKLERONMACHINEGUN,
				evolutionsID.SPRINKLER,
			]
		},
		
		evolutionsID.SNIPER: {
			evolutionsID.TSNIPER: [
				evolutionsID.TYSNIPER,
				evolutionsID.FOURWAYSNIPER,
			],
			evolutionsID.YSNIPER: [
				evolutionsID.UPGRADEDYSNIPER,
				evolutionsID.VYSNIPER,
				evolutionsID.SIXGUN,
				evolutionsID.TYSNIPER,
				evolutionsID.BACKWARDSHOTSNIPER,
			]
		},
		evolutionsID.DUAL: {
			evolutionsID.QUATERNARY: [
				evolutionsID.BIGQUATERNARY,
				evolutionsID.OCTAL,
			]
		},
		evolutionsID.THREEWAY: {
			evolutionsID.FIVEWAY: [
				evolutionsID.SIXWAY,
				evolutionsID.FOURWAYSNIPER,
				evolutionsID.BACKWARDSIXWAY,
			],
			
		}
	}
}

#no ideas why in the fluffings world it works
func search(node: Variant, target: int, result: Array) -> bool:
	if node is Dictionary:
		for key in node.keys():
			if key == target:
				var children = node[key]
				if children is Dictionary:
					result.append_array(children.keys())
				elif children is Array:
					result.append_array(children)
				return true
			if search(node[key], target, result):
				return true
	elif node is Array:
		for child in node:
			if search(child, target, result):
				return true
	return false

func getNextEvolutionsID(target: int, tree: Dictionary = evolutionTree) -> Array:
	var result: Array = []
	search(tree, target, result)
	return result

func getAllParents(target: int, tree: Dictionary = evolutionTree) -> Array:
	var parents: Array = []
	_search_parents(tree, target, parents)
	
	var uniqueParents = func remove_duplicates(arr: Array) -> Array:
		var uniqueElements = []
		for element in arr:
			if not uniqueElements.has(element):
				uniqueElements.append(element)
		return uniqueElements
	return uniqueParents.call(parents)

func _search_parents(node: Variant, target: int, parents: Array) -> void:
	if node is Dictionary:
		for key in node.keys():
			var children = node[key]
			if (children is Array and target in children) or (children is Dictionary and children.has(target)):
				parents.append(key)
			_search_parents(children, target, parents)
	elif node is Array:
		for child in node:
			_search_parents(child, target, parents)
