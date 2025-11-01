extends TextureRect

enum flags {USA, JAPAN}

var flagToTexture = {
	flags.USA : "res://Textures/flags/usa.png",
	flags.JAPAN : "res://Textures/flags/japon.png",
}
var flagToContryName = {}
var flagToLanguageName = {
	flags.USA : "ENGLISH",
	flags.JAPAN : "JAPANESE",
}

signal onSelect
var flag: flags

func make(flag: flags):
	flag = flag
	texture = load(flagToTexture[flag])
	$CenterContainer/Label.text = tr(flagToLanguageName[flag])


func _on_button_pressed() -> void:
	onSelect.emit(flag)
