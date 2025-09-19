extends Node

var playerInput = [
["up","down","left","right","kp0"],
["w","s","a","d","leftShift"],
["i","k","j","l",";"],
["kp8","kp5","kp4","kp6","kp+"]
]

func getPlayerInput(n: int, action: StringName):
	var inputs = getPlayerInputs(n)
	return getInputFromInputs(inputs, action)

func getPlayerInputs(n: int):
	return playerInput[n-1]
	
func getInputFromInputs(inputs: Array, action: StringName):
	match action:
		"foward":
			return inputs[0]
		"backward":
			return inputs[1]
		"left":
			return inputs[2]
		"right":
			return inputs[3]
		"shoot":
			return inputs[4]
