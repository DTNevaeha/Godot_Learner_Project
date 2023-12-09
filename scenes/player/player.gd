extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)


func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()

	# Rotate player
	look_at(get_global_mouse_position())

	# Shoot laser
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary action") and can_laser:
		$GPUParticles2D.emitting = true
		# Select a random laser marker
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		laser.emit(selected_laser.global_position, player_direction)

	# Throw grenade
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
