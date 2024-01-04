extends Area2D

signal player_entered
signal player_exited


func _on_body_entered(body: Node2D):
	if body.name == "Player":
		player_entered.emit()


func _on_body_exited(_body: Node2D):
	player_exited.emit()
