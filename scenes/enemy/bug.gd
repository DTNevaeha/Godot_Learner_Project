extends CharacterBody2D

var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_nearby: bool = false

var health = 20


func hit():
	if vulnerable:
		vulnerable = false
		$Timers/HitTimer.start()
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.9)
		$Particales/HitParticales.emitting = true
		$AudioStreamPlayer2D.play()
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _process(_delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed

	if active:
		move_and_slide()
		look_at(Globals.player_pos)


func _on_attack_area_body_entered(_body: Node2D):
	player_nearby = true
	$AnimatedSprite2D.play("attack")
	speed = 0


func _on_attack_area_body_exited(_body: Node2D):
	player_nearby = false
	$AnimatedSprite2D.play("walk")
	speed = 300


func _on_notice_area_body_exited(_body: Node2D):
	active = false
	$AnimatedSprite2D.stop()


func _on_notice_area_body_entered(body: Node2D):
	if body.name == "Player":
		active = true
		$AnimatedSprite2D.play("walk")


func _on_animated_sprite_2d_animation_finished():
	if player_nearby:
		Globals.health -= 10
		$Timers/AttackTimer.start()


func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)


func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("attack")
