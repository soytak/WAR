extends Node2D

var countdown_texts := ["3", "2", "1", "WAR"]
var index := 0
var tween: Tween

func _ready() -> void:
	%counter.hide()

func start_countdown(callback: Callable) -> void:
	index = 0
	showNext(callback)

func showNext(callback: Callable) -> void:
	if index >= countdown_texts.size():
		%counter.hide()
		callback.call()
		return
	
	%counter.show()
	%counter.text = countdown_texts[index]
	%counter.modulate = Color(1, 1, 1, 0)
	%counter.scale = Vector2.ONE * 0.4
	%counter.rotation = deg_to_rad(randf_range(-30, 30))
	
	if tween:
		tween.kill()
	tween = get_tree().create_tween()

	tween.tween_property(%counter, "modulate:a", 1.0, 0.3)
	tween.parallel().tween_property(%counter, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%counter, "rotation", 0.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.tween_callback(nextStep.bind(callback)).set_delay(0.3)

func nextStep(callback) -> void:
	index += 1
	showNext(callback)
