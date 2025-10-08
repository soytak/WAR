extends Control

func _ready() -> void:
	var screen_width = get_viewport_rect().size.x
	position.x = -screen_width
	hide()
	$center/panel/margin/Elements/BGM_Slider.value = musicManager.musicVolumeShift
	$center/panel/margin/Elements/SFX_Slider.value = sfxManager.sfxVolumeShift
	updateMinAFKTimerLabel()
	%enable.set_pressed(cursorManager.MinAFKTimeEnable)


func activate():
	show()
	var tween = create_tween()
	tween.tween_property(self, "position:x", 0, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		pass
	)
	
func deactivate():
	var screen_width = get_viewport_rect().size.x
	var tween = create_tween()
	tween.tween_property(self, "position:x", -screen_width, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		hide()
	)


func _on_sfx_slider_value_changed(value: float) -> void:
	sfxManager.setVolume(value)


func _on_bgm_slider_value_changed(value: float) -> void:
	musicManager.setVolume(value)


func _on_back_pressed() -> void:
	deactivate()




func _on_enable_toggled(toggled_on: bool) -> void:
	cursorManager.MinAFKTimeEnable = toggled_on


func _on_decrease_pressed() -> void:
	updateMinAFKTimerLabel(-1)

func _on_increase_pressed() -> void:
	updateMinAFKTimerLabel(1)

func _on_slight_increase_pressed() -> void:
	updateMinAFKTimerLabel(0.1)

func _on_slight_decrease_pressed() -> void:
	updateMinAFKTimerLabel(-0.1)

func updateMinAFKTimerLabel(timeChange: float = 0):
	cursorManager.MinAFKTime += timeChange
	cursorManager.MinAFKTime = clampf(cursorManager.MinAFKTime, 0.1, 10)
	$"center/panel/margin/Elements/CHT time box/time".text = str(cursorManager.MinAFKTime)
