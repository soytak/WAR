extends CanvasLayer

var height = -0.5

enum transitionTypes {CERCLEUP, CERCLEDOWN}

var shaderCercle = preload("res://Manager/transitionManager.gdshader")

func _process(delta: float) -> void:
	$transition.material.set_shader_parameter("height",height)

func playTransition(onTrans: Callable, time: float, color: Color = Color.WHITE, type: transitionTypes = transitionTypes.CERCLEUP):
	$transition.pivot_offset = $transition.size/2
	$CanvasModulate.color = color
	var tween = create_tween()
	if type == transitionTypes.CERCLEDOWN:
		$transition.rotation_degrees = 180
	else:
		$transition.rotation_degrees = 0
	tween.tween_property(self, "height", 1, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(fadeOut.bind(onTrans, time, type))

func fadeOut(onTrans: Callable, time: float, type: transitionTypes):
		onTrans.call()
		var outTween = create_tween()
		outTween.tween_property(self, "height", -0.5, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
