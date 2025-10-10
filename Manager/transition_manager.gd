extends Control

var height = -0.5
	
func _process(delta: float) -> void:
	$transition.material.set("shader_param/height",height)

func setColor(color: Color):
	$transition.modulate = color

func playTransition(onTrans: Callable, time: float):
	var tween = create_tween()
	tween.tween_property(self, "height", 1, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		onTrans.call()
		var outTween = create_tween()
		outTween.tween_property(self, "height", -0.5, time/2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		outTween.finished.connect(func():
			pass
		)
	)
