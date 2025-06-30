extends CharacterBody2D
signal health_depleted

@onready var sprite = $AnimatedSprite2D

var health = GameManager.health
var taking_damage = false
var is_animating = false

func _ready() -> void:
	sprite.play("idle")
	sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	# Handle animations
	if direction != Vector2.ZERO:
		if direction.x != 0:
			sprite.flip_h = direction.x < 0

			if taking_damage:
				sprite.play("hurt")
			else:	
				sprite.play("walk_right")
				#sprite.flip_h = direction.x < 0  # Flip if moving left
		else:
			if taking_damage:
				sprite.play("hurt")
			else:	
				sprite.play("walk_right")  # Or keep current animation
	else:
		if taking_damage:
				sprite.play("hurt")
		else:
			sprite.play("idle")
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = 	%HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		taking_damage = true
		%ProgressBar.value = health
		if health <= 0:
			handle_death()
			

func handle_death():
	set_physics_process(false)
	print("Player Died")
	sprite.stop()
	sprite.play("die")
		

func _on_animation_finished():
	var current_anim = sprite.animation
	if current_anim == "die":
		print("Die Completed:")
		print("emitting health depleted")		
		health_depleted.emit()
	elif current_anim == "hurt":
		print("Hurt Completed:")
		taking_damage = false
	else:
		print("Animation Finished", current_anim)
