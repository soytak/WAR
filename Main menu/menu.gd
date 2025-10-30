extends Control

@export var parallax_strength: Vector2 = Vector2(20, 20)
var maker = load("res://Game/tank maker/tank maker.tscn")
@onready var title = %Title
var initialTitlePosition
var time: float = 0
var vel = {
	"x" : 1,
	"y" : 1
}

func _ready() -> void:
	initialTitlePosition = title.position
	
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
	
	%tankPreviewControl.get_child(0).position.x += vel.x * 5
	%tankPreviewControl.get_child(0).position.y += vel.y * 5
	if %tankPreviewControl.get_child(0).position.x > %tankPreviewControl.get_parent().size.x or %tankPreviewControl.get_child(0).position.x < 0:
		vel.x = vel.x * -1
	if %tankPreviewControl.get_child(0).position.y > %tankPreviewControl.get_parent().size.y or %tankPreviewControl.get_child(0).position.y < 0:
		vel.y = vel.y * -1
	

func _on_controls_goal_pressed() -> void:
	%controls_goal.show()


func _on_dictionary_pressed() -> void:
	$TankDictionary.show()
