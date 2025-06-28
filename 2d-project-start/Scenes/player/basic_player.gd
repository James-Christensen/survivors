
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
	
	# Handle animations based on movement direction
	if direction != Vector2.ZERO:
		# Player is moving - determine which direction
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement is stronger
			if direction.x > 0:
				sprite.play("walk_right")
			else:
				sprite.play("walk_left")
		else:
			# Vertical movement is stronger (or equal)
			if direction.y > 0:
				sprite.play("walk_down")
			else:
				sprite.play("walk_up")
	else:
		# Player is not moving
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
