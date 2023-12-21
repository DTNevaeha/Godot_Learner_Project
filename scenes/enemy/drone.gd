extends CharacterBody2D

var health = 10
var vulnerable: bool = true


func _process(_delta):
	# Moving the drone to the right
	var direction = Vector2.RIGHT
	velocity = direction * 400
	move_and_slide()


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
	if health <= 0:
		queue_free()


func _on_hit_timer_timeout():
	vulnerable = true
