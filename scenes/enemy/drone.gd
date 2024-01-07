extends CharacterBody2D

var active: bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1

var health: int = 50
var vulnerable: bool = true

var explosion_active: bool = false
var explosion_radius: int = 400


func _ready():
	$Explosion.hide()
	$DroneImage.show()


func _process(delta):
	# Once the drone starts moving, it will move towards the player and never stop. Once it collides with anything or
	# dies, it will explode.
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			exploding()
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()


func hit():
	if vulnerable:
		health -= 10
		$DroneImage.material.set_shader_parameter("progress", 0.9)
		vulnerable = false
		if explosion_active == false:
			$HitTimer.start()
			$Sounds/HitSound.play()
	if health <= 0:
		exploding()


func exploding():
	explosion_active = true
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("explosion")
	await get_tree().create_timer(0.5).timeout
	SoundManager.explosion_sound(global_position)


func stop_movement():
	# This is to stop the drone from moving after it starts to explode
	speed_multiplier = 0


func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress", 0)


func _on_notice_area_body_entered(_body: Node2D):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)
