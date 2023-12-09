extends CharacterBody2D

var direction = Vector2.RIGHT

func _process(_delta):
	
	velocity = direction * 400

	move_and_slide()

func _ready():
	
	if position.x > 500:
		direction = Vector2.LEFT
		velocity = direction * 500
	else:
		direction = Vector2.RIGHT
		velocity = direction * 100
