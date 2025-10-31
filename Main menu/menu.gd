extends Control

@export var parallax_strength: Vector2 = Vector2(20, 20)
var maker = load("res://Game/tank maker/tank maker.tscn")
@onready var title = %Title
var initialTitlePosition
var time: float = 0
var vels: Array[Dictionary]

func _ready() -> void:
	initialTitlePosition = title.position
	
	for i in range(SaveManager.TTA):
		createPreview()
		
	playMusic()

func createPreview():
	var makerInstance = maker.instantiate()
	makerInstance.modulate = global.playersColors[randi_range(0,3)]
	makerInstance.scale = Vector2.ONE * 2
	makerInstance.rotation = randf_range(0, 360)
	makerInstance.position.x = randf_range(0, 1920)
	makerInstance.position.y = randf_range(0, 1080)
	%tankPreviewControl.add_child(makerInstance)
	makerInstance.make(randi_range(0, evolutionManager.evolutionsID.size() - 1))
	var vel: Dictionary = {
		"x": randi_range(0, 1)*2-1,
		"y": randi_range(0, 1)*2-1,
		"rot": randf_range(-2, 2),
	}
	vels.append(vel)

func playMusic() -> void:
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-163.wav"))
		return
	if randi_range(1,100) == 1:
		musicManager.play_music(preload("res://Vocals/463-001.wav"))
		return
	if randi_range(1,15) == 1:
		musicManager.play_music(preload("res://Musics/Title2.wav"))
		return
	musicManager.play_music(preload("res://Musics/Title.mp3"))


func _process(delta):
	time += delta
	title.position = initialTitlePosition + Vector2(0, sin(time)*10)
	var viewport_center = get_viewport_rect().size / 2
	var mouse_offset = (get_viewport().get_mouse_position() - viewport_center) / viewport_center
	%BG.position = mouse_offset * parallax_strength * -0.7 - Vector2(50,50)
	$paralax.offset = mouse_offset * parallax_strength * 0.3
	
	if %tankPreviewControl.get_children().size() > SaveManager.TTA:
		for i in range(%tankPreviewControl.get_children().size()-SaveManager.TTA):
			%tankPreviewControl.get_child(0).queue_free()
	if %tankPreviewControl.get_children().size() < SaveManager.TTA:
		for i in range(SaveManager.TTA-%tankPreviewControl.get_children().size()):
			createPreview()
	
	var i = 0
	for child in %tankPreviewControl.get_children():
		child.position.x += vels[i].x * 5
		child.position.y += vels[i].y * 5
		
		child.rotation_degrees += vels[i].rot
		if child.position.x > %tankPreviewControl.get_parent().size.x or child.position.x < 0:
			vels[i].x = vels[i].x * -1
		if child.position.y > %tankPreviewControl.get_parent().size.y or child.position.y < 0:
			vels[i].y = vels[i].y * -1
		i+=1
	

func _on_controls_goal_pressed() -> void:
	%controls_goal.show()


func _on_dictionary_pressed() -> void:
	%TankDictionary.show()
