extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP


func _ready():
	$SelfDestructTimer.start()


func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body: Node2D):
	if "hit" in body:
		body.hit()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()


func _on_self_destruct_timer_timeout():
	queue_free()
