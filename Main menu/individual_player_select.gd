extends TextureButton

var player: int
var playerData: PlayerData

func _ready() -> void:
	playerData = global.playersData[player-1]
	playerData.playerType = global.playerTypes.NONE
	custom_minimum_size = Vector2(1920/2, 1080/2)
	loadTexture()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.has_meta("player"):
			if get_rect().has_point(event.position) and event.get_meta("player") == player:
				_on_pressed()
				accept_event()
		else:
			if get_rect().has_point(event.position):
				_on_pressed()
				accept_event()

func _on_pressed() -> void:
	match playerData.playerType:
		global.playerTypes.NONE:
			playerData.playerType = global.playerTypes.PLAYER
		global.playerTypes.PLAYER:
			playerData.playerType = global.playerTypes.BOT
		global.playerTypes.BOT:
			playerData.playerType = global.playerTypes.NONE
			
	loadTexture()

func loadTexture() -> void:
	var prefix: StringName
	if playerData.playerType == global.playerTypes.NONE:
		texture_normal = load("res://Textures/player select/none.png")
		return
	if playerData.playerType == global.playerTypes.PLAYER:
		prefix = "player"
	if playerData.playerType == global.playerTypes.BOT:
		prefix = "bot"
	texture_normal = load("res://Textures/player select/"+ prefix + str(player) +".png")
