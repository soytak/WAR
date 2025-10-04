extends Control

@export var parallax_strength: Vector2 = Vector2(20, 20)
var maker = load("res://Game/tank maker/tank maker.tscn")

func _ready() -> void:
	var makerInstance = maker.instantiate()
	makerInstance.modulate = global.playersColors[randi_range(0,3)]
	makerInstance.scale = Vector2.ONE * 2
	makerInstance.rotation = randf_range(0,360)
	makerInstance.position.x = randf_range(-10, 10)
	makerInstance.position.y = randf_range(-10, 10)
	%tankPreviewControl.add_child(makerInstance)
	makerInstance.make(randi_range(0, evolutionManager.evolutionsID.size() - 1))
	playMusic()

func playMusic() -> void:
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-163.wav"))
		return
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-001.wav"))
		return
	if randi_range(1,10) == 1:
		musicManager.play_music(preload("res://Musics/Title2.wav"))
		return
	musicManager.play_music(preload("res://Musics/Title.mp3"))


func _process(delta):
	var viewport_center = get_viewport_rect().size / 2
	var mouse_offset = (get_viewport().get_mouse_position() - viewport_center) / viewport_center
	$BG.position = mouse_offset * parallax_strength * -0.7 - Vector2(50,50)
	position = mouse_offset * parallax_strength * 0.3


func _on_controls_goal_pressed() -> void:
	$controls_goal.show()
