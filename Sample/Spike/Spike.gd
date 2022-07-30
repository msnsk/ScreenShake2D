extends Area2D

signal stepped

func _on_Spike_body_entered(body):
	if body.name == "Player":
		emit_signal("stepped")
