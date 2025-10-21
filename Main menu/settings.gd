extends Control

enum navigationPanels {SOUND, CURSOR, BINDINGS, CREDITS}

var navigationPanel: navigationPanels = navigationPanels.SOUND

var playerTab = preload("res://playerTab.tscn")
var currentPlayerTab: int = -1

func _ready() -> void:
	onPlayerTabSelect(1)
	for child in $center/panels/bindings/margin/VBoxContainer/HBoxContainer.get_children():
		for keybinds in child.get_children():
			keybinds.remap.connect(%"rebind popup".rebind)
	
	
	sfxManager.setVolume(navigationPanels.SOUND)
	
	var screen_width = get_viewport_rect().size.x
	position.x = -screen_width
	hide()
	%BGM_Slider.value = musicManager.musicVolumeShift
	%SFX_Slider.value = sfxManager.sfxVolumeShift
	updateMinAFKTimerLabel()
	%enable.set_pressed(cursorManager.MinAFKTimeEnable)
	
	for i in range(4):
		var newPlayerTab = playerTab.instantiate()
		newPlayerTab.player = i+1
		newPlayerTab.onClick.connect(onPlayerTabSelect)
		%playerTabs.add_child(newPlayerTab)

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
	cursorManager.enableCursors()


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
	%"cursor time".text = str(cursorManager.MinAFKTime)


func _on_bsound_pressed() -> void:
	setNavigation(navigationPanels.SOUND)

func _on_bcursor_pressed() -> void:
	setNavigation(navigationPanels.CURSOR)

func _on_bkey_pressed() -> void:
	setNavigation(navigationPanels.BINDINGS)

func _on_bcredits_pressed() -> void:
	setNavigation(navigationPanels.CREDITS)


func setNavigation(navigation: navigationPanels) -> void:
	navigationPanel = navigation
	for panel in %panels.get_children():
		if panel == %sideBar: continue
		panel.hide()
	
	match navigation:
		navigationPanels.SOUND:
			%sound.show()
		navigationPanels.CURSOR:
			%cursor.show()
		navigationPanels.CREDITS:
			%credits.show()
		navigationPanels.BINDINGS:
			%bindings.show()

func onPlayerTabSelect(player: int):
	currentPlayerTab = player
	%up.update(player)
	%down.update(player)
	%left.update(player)
	%right.update(player)
	%primary.update(player)
	%esc.update(player)
