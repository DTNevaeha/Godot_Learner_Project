extends Node2D

var speed: int = 300
var move_up: bool = true
var move_down: bool = false
var direction: Vector2 = Vector2.UP
var distance: int = 500
var moved_distance: float = 0.0


# func _process(delta):
# 	if $Timer.is_stopped():
# 		return
# 	if move_up:
# 		global_position += direction * speed * delta
# 	else:
# 		global_position -= direction * speed * delta


# func _on_timer_timeout():
# 	move_up = not move_up
# 	$Timer.stop()
# 	await get_tree().create_timer(2.0).timeout
# 	$Timer.start()
	

func _physics_process(delta):
	var move_step = speed * delta
	if move_up and moved_distance < distance:
		if moved_distance + move_step > distance:
			move_step = distance - moved_distance
		position.y -= move_step
		moved_distance += move_step
	elif move_up:
		await get_tree().create_timer(2.0).timeout
		move_up = false
		move_down = true
	
	if move_down and moved_distance > 0:
		if moved_distance - move_step < 0:
			move_step = moved_distance
		position.y += move_step
		moved_distance -= move_step
	elif move_down:
		await get_tree().create_timer(2.0).timeout
		move_up = true
		move_down = false
