extends Node2D


onready var type_label = $CanvasLayer/TypeLabel


func _unhandled_input(event):
	if event.is_action_pressed("ui_right")\
	or event.is_action_pressed("ui_left"):
		if type_label.text == "ROUGH":
			type_label.text = "SMOOTH"
		else:
			type_label.text = "ROUGH"
