extends Node

var path := "user://settings.ini"

func saveSettings() -> void:
	var config = ConfigFile.new()

	config.set_value("volume", "bgm", musicManager.musicVolumeShift)
	config.set_value("volume", "sfx", sfxManager.sfxVolumeShift)

	config.set_value("cursor", "AFKEnabled", cursorManager.MinAFKTimeEnable)
	config.set_value("cursor", "AFKMinTimer", cursorManager.MinAFKTime)

	var error = config.save(path)

func loadSettings() -> void:
	var config = ConfigFile.new()
	if FileAccess.file_exists(path):
		var error = config.load(path)
		if error != OK:
			print("Failed to load settings!")
			return

		var bgmVolume = config.get_value("volume", "bgm", musicManager.musicVolumeShift)
		var sfxVolume = config.get_value("volume", "sfx", sfxManager.sfxVolumeShift)

		var cursorEnabled = config.get_value("cursor", "AFKEnabled", cursorManager.MinAFKTimeEnable)
		var cursorAFKTime = config.get_value("cursor", "AFKMinTimer", cursorManager.MinAFKTime)

		musicManager.setVolume(bgmVolume)
		sfxManager.setVolume(sfxVolume)
		cursorManager.MinAFKTimeEnable = cursorEnabled
		cursorManager.MinAFKTime = clampf(cursorAFKTime, 0.1, 10)
	else:
		print("No settings file found. Using defaults.")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saveSettings()
