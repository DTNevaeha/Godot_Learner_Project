extends Node2D

var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")


func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)


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


# func _process(_delta):
# 	var max_distance = 500
# 	# If projectiles have moved further than the max distance then they are removed from the list
# 	for projectile in $Projectiles.get_children():
# 		if (
# 			projectile.has_method("has_traveled_too_far")
# 			and projectile.has_traveled_too_far(max_distance)
# 		):
# 			projectile.queue_free()


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	# tween.tween_property($Player, "modulate:a", 0, 2).from(0.5)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 1, 2)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
