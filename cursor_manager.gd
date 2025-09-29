extends Control

var cursora = preload("res://cursor.tscn")

func _ready() -> void:
	z_index = 20
	for i in range(4):
		var newCursor = cursora.instantiate()
		newCursor.player = i+1
		#add_child(newCursor)

func disableCursors():
	for child in get_children():
		child.hide()

func enableCursors():
	for child in get_children():
		child.show()
