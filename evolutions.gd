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
DOUBLEGUN, SNIPER, THREEWAY, DOUBLESHOT, DUAL, BIG, UPGRADEDBASIC, MACHINEGUN, LANDMINE,
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
			return "Basic"
		evolutionsID.DOUBLEGUN:
			return "Double gun"
		evolutionsID.SNIPER:
			return "Sniper"
		evolutionsID.THREEWAY:
			return "Three way"
		evolutionsID.DOUBLESHOT:
			return "Double shot"
		evolutionsID.DUAL:
			return "Dual"
		evolutionsID.BIG:
			return "Big"
		evolutionsID.UPGRADEDBASIC:
			return "Upgraded basic"
		evolutionsID.MACHINEGUN:
			return "Machine gun"
		evolutionsID.LANDMINE:
			return "Landmine"
		evolutionsID.TRIPLESHOT:
			return "Triple shot"
		evolutionsID.QUADRIPLESHOT:
			return "Quadriple shot"
		evolutionsID.VDOUBLESHOT:
			return "V Ddouble shot"
		evolutionsID.UPGRADEDUPGRADEDBASIC:
			return "Upgraded upgraded basic"
		evolutionsID.UPGRADEDUPGRADEDUPGRADEDBASIC:
			return "Upgraded upgraded upgraded basic"
		#evolutionsID.RNG:
			#return "RNG"
		evolutionsID.BACKWARDSHOT:
			return "Backward shot"
		evolutionsID.BACKWARDSHOTSNIPER:
			return "Backward shot sniper"
		evolutionsID.BACKWARDSIXWAY:
			return "Backward six way"
		evolutionsID.DROPPER:
			return "Dropper"
		evolutionsID.UPGRADEDDROPPER:
			return "Upgraded dropper"
		evolutionsID.LANDMINEONDROPPER:
			return "Landmine on dropper"
		evolutionsID.TSNIPER:
			return "T Sniper"
		evolutionsID.TYSNIPER:
			return "TY Sniper"
		evolutionsID.FOURWAYSNIPER:
			return "Four way sniper"
		evolutionsID.YSNIPER:
			return "Y sniper"
		evolutionsID.UPGRADEDYSNIPER:
			return "Upgraded sniper"
		evolutionsID.VYSNIPER:
			return "VY sniper"
		evolutionsID.FOURGUN:
			return "Four gun"
		evolutionsID.SIXGUN:
			return "Six gun"
		evolutionsID.SMALLSPRINKLERONMACHINEGUN:
			return "Small sprinkle on machinegun"
		evolutionsID.SPRINKLER:
			return "Sprinkler"
		evolutionsID.QUATERNARY:
			return "Quaternary"
		evolutionsID.BIGQUATERNARY:
			return "Big quaternary"
		evolutionsID.OCTAL:
			return "Octal"
		evolutionsID.FIVEWAY:
			return "Five way"
		evolutionsID.SIXWAY:
			return "Six way"
		evolutionsID.UPGRADEDMACHINEGUN:
			return "Upgraded machinegun"
		evolutionsID.UPGRADEDBIG:
			return "Upgraded big"
		evolutionsID.UPGRADEDBIGTWOWAY:
			return "Upgraded big two way"
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
