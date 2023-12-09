extends Node2D

var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
 

func _on_gate_player_entered_gate(body):
	print("player entered gate")
	print(body)


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _process(_delta):
	var max_distance = 500
	# If projectiles have moved further than the max distance then they are removed from the list
	for projectile in $Projectiles.get_children():
		if projectile.has_method("has_traveled_too_far") and projectile.has_traveled_too_far(max_distance):
			projectile.queue_free()
