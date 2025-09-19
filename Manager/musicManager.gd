extends Node

@export var default_volume_db: float = 0.0
@export var fade_duration: float = 1.0

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Master"
	music_player.volume_db = default_volume_db
	music_player.autoplay = false
	music_player.stream_paused = true

func play_music(new_stream: AudioStream):
	if music_player.stream == new_stream:
		return
	
	if music_player.playing:
		fade_to_new_music(new_stream)
	else:
		start_music(new_stream)

func start_music(stream: AudioStream):
	music_player.stream = stream
	music_player.volume_db = -80
	music_player.play()
	fade_in_music()

func fade_to_new_music(new_stream: AudioStream):
	var t = create_tween()
	t.tween_property(music_player, "volume_db", -80, fade_duration)
	t.connect("finished", Callable(self, "_on_fade_out_finished").bind(new_stream))

func fade_in_music():
	var t = create_tween()
	t.tween_property(music_player, "volume_db", default_volume_db, fade_duration)

func _on_fade_out_finished(new_stream: AudioStream):
	start_music(new_stream)
