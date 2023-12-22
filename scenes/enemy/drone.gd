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
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			explosion_active = true
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
		$HitTimer.start()
	if health <= 0:
		explosion_active = true
		$AnimationPlayer.play("explosion")


func stop_movement():
	speed_multiplier = 0


func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress", 0)


func _on_notice_area_body_entered(_body: Node2D):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)
