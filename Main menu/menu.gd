extends Control

@export var parallax_strength: Vector2 = Vector2(20, 20)

func _ready() -> void:
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-163.wav"))
		return
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-001.wav"))
		return
	if randi_range(1,5) == 1:
		musicManager.play_music(preload("res://Musics/Title2.wav"))
		return
	musicManager.play_music(preload("res://Musics/Title.mp3"))

func _process(delta):
	var viewport_center = get_viewport_rect().size / 2
	var mouse_offset = (get_viewport().get_mouse_position() - viewport_center) / viewport_center
	$Panel.position = mouse_offset * parallax_strength * -0.7
	position = mouse_offset * parallax_strength * 0.3
