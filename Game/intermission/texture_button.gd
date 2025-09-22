extends TextureButton

var originalColor: Color
var darkenedColor: Color = Color(0.6, 0.6, 0.6)
var dispName: StringName
var obtained: bool = false
signal onClick

func _ready() -> void:
	originalColor = self.modulate
	tooltip_text = dispName

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "self_modulate", darkenedColor, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.finished.connect(func (): pass)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "self_modulate", originalColor, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.finished.connect(func (): pass)

func _on_button_down() -> void:
	if not obtained:
		obtained = true
		onClick.emit(dispName)
		
