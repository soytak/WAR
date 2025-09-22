extends TextureRect

var player: int
var speed: int = 10

func _ready() -> void:
	print(player)
	self_modulate = global.playersColors[player - 1]

func _process(delta: float) -> void:
	var press := Input.is_action_just_pressed(global.getPlayerInput(player, "shoot"))
	if Input.is_action_pressed(global.getPlayerInput(player, "shoot")):
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE

	position.y += Input.get_axis(global.getPlayerInput(player, "foward"), global.getPlayerInput(player, "backward")) * speed
	position.x += Input.get_axis(global.getPlayerInput(player, "left"), global.getPlayerInput(player, "right")) * speed
	position.x = clamp(position.x, 0, get_viewport_rect().size.x - size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y - size.y)
	if press:
		_simulate_global_click()

func _simulate_global_click() -> void:
	var click_press := InputEventMouseButton.new()
	click_press.button_index = MOUSE_BUTTON_LEFT
	click_press.pressed = true
	click_press.position = position + size / 2
	Input.parse_input_event(click_press)
	print(click_press.position)
	var click_release := InputEventMouseButton.new()
	click_release.button_index = MOUSE_BUTTON_LEFT
	click_release.pressed = false
	click_release.position = position + size / 2
	Input.parse_input_event(click_release)
