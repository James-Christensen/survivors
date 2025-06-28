extends CharacterBody2D
signal health_depleted

@onready var sprite = $AnimatedSprite2D

var health = GameManager.health

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	# Handle animations
	if direction != Vector2.ZERO:
		if direction.x != 0:
			# Horizontal movement
			sprite.play("walk_right")
			sprite.flip_h = direction.x < 0  # Flip if moving left
		else:
			# Only vertical movement - you could use walk animation or create separate up/down
			sprite.play("walk_right")  # Or keep current animation
			# Don't change flip_h when moving vertically
	else:
		sprite.play("idle")
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = 	%HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health  <= 0:
			health_depleted.emit()
	


func _on_health_depleted() -> void:
	pass # Replace with function body.
