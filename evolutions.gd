extends Node

enum evolutionsID {BASIC,
DOUBLEGUN, SNIPER, THREEWAY, DOUBLESHOT, DUAL, BIG, UPGRADEDBASIC, MACHINEGUN, LANDMINE,
#############################             ################################################

#DOUBLESHOT
TRIPLESHOT, #1
QUADRIPLESHOT, VDOUBLESHOT,




#done UPGRADEDBASIC
UPGRADEDUPGRADEDBASIC,#1
UPGRADEDUPGRADEDUPGRADEDBASIC, RNG, #SPRINKLER
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

#landmine done
LANDMINEFACTORY,#1
GRAVITATIONNALLANDMINEFACTORY,UPGRADEDLANDMINEFACTORY,
LANDMINEWITHCANON,#2
LANDMINEWITHTHREEWAYCANON,LANDMINEWITHDOUBLEMINECANON, #LANDMINEONDROPPER
}

var evolutionTree = {
	evolutionsID.BASIC: {

		evolutionsID.UPGRADEDBASIC: {
			evolutionsID.UPGRADEDUPGRADEDBASIC: [
				evolutionsID.UPGRADEDUPGRADEDUPGRADEDBASIC,
				evolutionsID.RNG,
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
		
		evolutionsID.LANDMINE: {
			evolutionsID.LANDMINEFACTORY: [
				evolutionsID.GRAVITATIONNALLANDMINEFACTORY,
				evolutionsID.UPGRADEDLANDMINEFACTORY,
			],
			evolutionsID.LANDMINEWITHCANON: [
				evolutionsID.LANDMINEWITHTHREEWAYCANON,
				evolutionsID.LANDMINEWITHDOUBLEMINECANON,
			]
		},
		
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
