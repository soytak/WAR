extends TextureRect

enum flags {USA, JAPAN}

var flagToTexture = {
	flags.USA : "res://Textures/flags/usa.png",
	flags.JAPAN : "res://Textures/flags/japon.png",
}
var flagToContryName = {}
var flagToLanguageName = {
	flags.USA : "English",
	flags.JAPAN : "Japanese",
}

func make(flag: flags):
	texture = load(flagToTexture[flag])
	$CenterContainer/Label.text = flagToLanguageName[flag]
