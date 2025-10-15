extends TextureButton

var originalColor: Color
var darkenedColor: Color = Color(0.6, 0.6, 0.6)
var obtainedColor: Color = Color(0.4, 0.4, 0.4)
var dispName: StringName
var obtained: bool = false
var player: int = -1
signal onClick

func _ready() -> void:
	originalColor = self.modulate
	tooltip_text = dispName

func _on_mouse_entered() -> void:
	if obtained == false:
		var tween = create_tween()
		tween.tween_property(self, "self_modulate", darkenedColor, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.finished.connect(func (): pass)


func _on_mouse_exited() -> void:
	if obtained == false:
		var tween = create_tween()
		tween.tween_property(self, "self_modulate", originalColor, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.finished.connect(func (): pass)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and get_rect().has_point((event.position)):
		print(2)
		if event.has_meta("player") and event.get_meta("player") == player:
			_on_button_down()
		elif not event.has_meta("player"):
			_on_button_down()


func _on_button_down() -> void:
	if not obtained:
		obtained = true
		onClick.emit(dispName)
		
		var tween = create_tween()
		tween.tween_property(self, "self_modulate", obtainedColor, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.finished.connect(func (): pass)
		
