extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)
signal update_stats

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	# Rotate player
	look_at(get_global_mouse_position())

	# Shoot laser
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		# Select a random laser marker
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		laser.emit(selected_laser.global_position, player_direction)

	# Throw grenade
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true

func add_item(type: String) -> void:
	if type == "laser":
		Globals.laser_amount += 5
	elif type == "grenade":
		Globals.grenade_amount += 1
	# elif type == "health":
	# 	Globals.health += 10
	else:
		print("Unknown item type: " + type)
	update_stats.emit()