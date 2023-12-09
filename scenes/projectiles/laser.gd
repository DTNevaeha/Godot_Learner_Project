extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
var start_position = Vector2()


func _ready():
	start_position = position


func _process(delta):
	position += direction * speed * delta


func has_traveled_too_far(max_distance):
	# The laser start position should start at the laser.position
	var traveled_distance = position.distance_to(start_position)
	return traveled_distance > max_distance
