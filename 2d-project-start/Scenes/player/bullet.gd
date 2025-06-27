extends Area2D
var travelled_distance = 0

func _physics_process(delta):

	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * GameManager.bullet_speed *delta
	travelled_distance += GameManager.bullet_speed * delta
	
	if travelled_distance > GameManager.bullet_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
 # Replace with function body.
