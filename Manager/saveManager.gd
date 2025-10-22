extends Node

var path := "user://settings.ini"

func saveSettings() -> void:
	save_input_map()
	var config = ConfigFile.new()

	config.set_value("volume", "bgm", musicManager.musicVolumeShift)
	config.set_value("volume", "sfx", sfxManager.sfxVolumeShift)

	config.set_value("cursor", "AFKEnabled", cursorManager.MinAFKTimeEnable)
	config.set_value("cursor", "AFKMinTimer", cursorManager.MinAFKTime)

	



	var error = config.save(path)

func loadSettings() -> void:
	loadInputMap()
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
		
func save_input_map(path: String = "user://input_map.json") -> void:
	var data: Dictionary = {}

	for action_name in InputMap.get_actions():
		if "ui" in action_name:
			continue

		var events: Array = []
		for event in InputMap.action_get_events(action_name):
			events.append(event.as_text())
		data[action_name] = events

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()
	else:
		push_error("Failed to save input map to: " + path)
		
func loadInputMap(path: String = "user://input_map.json") -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file:
		var string = file.get_as_text()
		file.close()
		
		var newJson = JSON.new()
		newJson.parse(string)
	
