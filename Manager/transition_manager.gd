extends Control

var height = -0.5

enum transitionTypes {CERCLEUP, CERCLEDOWN}

var shaderCercle = preload("res://Manager/transitionManager.gdshader")

func _process(delta: float) -> void:
	$transition.material.set_shader_parameter("height",height)

func setColor(color: Color):
	$transition.modulate = color

func playTransition(onTrans: Callable, time: float, type: transitionTypes = transitionTypes.CERCLEUP):
	pivot_offset = size/2
	
	var tween = create_tween()
	if type == transitionTypes.CERCLEDOWN:
		rotation_degrees = 180
	else:
		rotation_degrees = 0
	tween.tween_property(self, "height", 1, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(fadeOut.bind(onTrans, time, type))

func fadeOut(onTrans: Callable, time: float, type: transitionTypes):
		onTrans.call()
		var outTween = create_tween()
		outTween.tween_property(self, "height", -0.5, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
