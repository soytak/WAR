extends Control

var currentEvolutionId: int = 0
@onready var preview = %TankMaker

func _ready() -> void:
	updateName()

func updateName():
	var name = evolutionManager.getEvolutionIdName(currentEvolutionId)
	%"Tank name".text = name
	preview.make(currentEvolutionId)
	preview.position = Vector2(0,0)
	preview.scale = Vector2.ONE * 2

func _on_previous_pressed() -> void:
	changeCurrentEvolutionId(-1)


func _on_next_pressed() -> void:
	changeCurrentEvolutionId(1)

func changeCurrentEvolutionId(change: int, setting: bool = false):
	if setting:
		currentEvolutionId = change % evolutionManager.evolutionsID.size()
	else:
		currentEvolutionId = (currentEvolutionId+change) % evolutionManager.evolutionsID.size()
	updateName()


func _on_exit_pressed() -> void:
	$".".hide()
