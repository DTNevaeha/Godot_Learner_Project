extends Area2D

var rotation_speed: int = 4
var avaliable_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = avaliable_options[randi() % len(avaliable_options)]

var direction: Vector2
var distance: int = randi_range(150, 250)


func _ready():
	# Items are randomly generated based on the avaliable_options variable
	if type == "laser":
		$Sprite2D.modulate = Color(0.1, 0.2, 0.8)
	elif type == "grenade":
		$Sprite2D.modulate = Color(0.8, 0.2, 0.1)
	elif type == "health":
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1)

	# tweens
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))


func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D):
	if type == "health":
		Globals.health += 10
	elif type == "laser":
		Globals.laser_amount += 5
	elif type == "grenade":
		Globals.grenade_amount += 1
	else:
		print("Unknown item type: " + type)
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
