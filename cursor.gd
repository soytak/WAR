extends TextureRect

var player: int
var speed: int = 10
var canShow: bool = true

func _ready() -> void:
	self_modulate = global.playersColors[player - 1]

func _process(delta: float) -> void:
	var press := Input.is_action_just_pressed(global.getPlayerInput(player, "shoot"))
	if Input.is_action_pressed(global.getPlayerInput(player, "shoot")):
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE

	var diffY = Input.get_axis(global.getPlayerInput(player, "foward"), global.getPlayerInput(player, "backward")) * speed
	var diffX = Input.get_axis(global.getPlayerInput(player, "left"), global.getPlayerInput(player, "right")) * speed
	
	position.x = clamp(position.x + diffX, 0, get_viewport_rect().size.x - size.x)
	position.y = clamp(position.y + diffY, 0, get_viewport_rect().size.y - size.y)
	if press:
		_simulate_global_click()
	
	if cursorManager.MinAFKTimeEnable:
		if press or diffX != 0 or diffY != 0:
			if canShow: show()
			$Timer.paused = true
		else:
			if $Timer.paused: 
				$Timer.paused = false
				$Timer.start(cursorManager.MinAFKTime)
		
	if not canShow and visible:
		hide()
			
	

func _input(event):
	if event is InputEventMouseButton: 
		pass
	
func _simulate_global_click() -> void:
	var viewport := get_viewport()
	
	var local_center := size / 2
	var canvas_xform := get_global_transform_with_canvas()

	var click_pos := canvas_xform * local_center
	click_pos = viewport.get_final_transform() * click_pos

	var click_press := InputEventMouseButton.new()
	click_press.button_index = MOUSE_BUTTON_LEFT
	click_press.pressed = true
	click_press.position = click_pos
	click_press.set_meta("player", player)
	Input.parse_input_event(click_press)

	var click_release := InputEventMouseButton.new()
	click_release.button_index = MOUSE_BUTTON_LEFT
	click_release.pressed = false
	click_release.position = click_pos
	click_release.set_meta("player", player)
	Input.parse_input_event(click_release)


func _on_timer_timeout() -> void:
	hide()

func enable():
	canShow = true
	if not cursorManager.MinAFKTimeEnable:
		show()
	else:
		$Timer.paused = false
		$Timer.start(cursorManager.MinAFKTime)

func disable():
	canShow = false
