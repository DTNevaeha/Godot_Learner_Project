extends Node2D

@onready var top_direction: Vector2 = Vector2.DOWN.rotated(rotation)
@onready var bottom_direction: Vector2 = Vector2.UP.rotated(rotation)

var top_wall: bool = false
var bottom_wall: bool = false
var player_nearby: bool = false

signal trap_shoot(pos, direction)


func _process(_delta):
	if top_wall and player_nearby:
		var top_markers = $TopWall.get_children()
		for tmarker in top_markers:
			var pos: Vector2 = tmarker.global_position
			var direction: Vector2 = top_direction
			trap_shoot.emit(pos, direction)
			top_wall = false
		$Timers/TopTimer.start()
		await get_tree().create_timer(1.0).timeout
		var bottom_markers = $BottomWall.get_children()
		for bmarker in bottom_markers:
			var pos: Vector2 = bmarker.global_position
			var direction: Vector2 = bottom_direction
			trap_shoot.emit(pos, direction)
			bottom_wall = false


func _on_top_timer_timeout():
	top_wall = true


func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Player":
		player_nearby = true
		$Timers/TopTimer.start()


func _on_area_2d_body_exited(_body:Node2D):
	player_nearby = false



