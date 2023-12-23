extends PathFollow2D

var player_nearby: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

@onready var gun_fire1: Sprite2D = $Turret/GunFire1
@onready var gun_fire2: Sprite2D = $Turret/GunFire2


func fire():
	# The gun fire image appears when the turret fires
	Globals.health -= 20
	gun_fire1.modulate.a = 1
	gun_fire2.modulate.a = 1

	# Create gun fire animation that disappears after fired
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire2, "modulate:a", 0, randf_range(0.1, 0.5))


func _ready():
	# Line2 target point is created to match line1
	line2.add_point($Turret/RayCast2D2.target_position)


func _process(delta):
	# Controls the car speed and for turret to look at player
	progress_ratio += 0.01 * delta
	if player_nearby:
		$Turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(_body: Node2D):
	player_nearby = true
	$AnimationPlayer.play("laser_load")


func _on_notice_area_body_exited(_body: Node2D):
	# When player leaves the turret's notice area, the lasers slowly disappear
	player_nearby = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line2, "width", 0, randf_range(0.1, 0.5))
	await tween.finished
	$AnimationPlayer.stop()
