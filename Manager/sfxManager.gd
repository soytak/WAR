extends Node

var sfxVolumeShift: float = 1

func _ready() -> void: setVolume(sfxVolumeShift)
func setVolume(volume):
	sfxVolumeShift = volume
	var bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(
		bus,
		linear_to_db(sfxVolumeShift)
	)
