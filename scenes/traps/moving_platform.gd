extends Node2D

var speed: int = 200
var distance: int = 500
var move_up: bool = true
var direction: Vector2 = Vector2.UP


func _process(delta):
	if move_up:
		global_position += direction * speed * delta
	else:
		global_position -= direction * speed * delta


func _on_timer_timeout():
	move_up = not move_up
