extends Node2D

var floor_active: bool = true

var top_left: bool = false
var top_right: bool = false
var bottom_left: bool = false
var bottom_right: bool = false


func _process(_delta):
	if floor_active:
		$FloorTiles/TopLeft.visible = true
		$FloorTiles/TopRight.visible = false
		$FloorTiles/BottomLeft.visible = false
		$FloorTiles/BottomRight.visible = true
	else:
		$FloorTiles/TopLeft.visible = false
		$FloorTiles/TopRight.visible = true
		$FloorTiles/BottomLeft.visible = true
		$FloorTiles/BottomRight.visible = false
	
	# Check if player is on active floor
	if top_left and $FloorTiles/TopLeft.visible:
			player_damage()
	elif top_right and $FloorTiles/TopRight.visible:
			player_damage()
	elif bottom_left and $FloorTiles/BottomLeft.visible:
			player_damage()
	elif bottom_right and $FloorTiles/BottomRight.visible:
			player_damage()


func player_damage():
	Globals.health -= 10

	
func _on_top_left_body_entered(_body: Node2D):
		top_left = true


func _on_bottom_right_body_entered(_body: Node2D):
		bottom_right = true


func _on_bottom_left_body_entered(_body: Node2D):
		bottom_left = true


func _on_top_right_body_entered(_body: Node2D):
		top_right = true


func _on_bottom_right_body_exited(_body: Node2D):
	bottom_right = false


func _on_bottom_left_body_exited(_body: Node2D):
	bottom_left = false


func _on_top_right_body_exited(_body: Node2D):
	top_right = false


func _on_top_left_body_exited(_body: Node2D):
	top_left = false


func _on_timer_timeout():
	floor_active = not floor_active
