extends CharacterBody2D
signal health_depleted

enum PlayerState { NORMAL, HURT, DYING }

@onready var sprite = $AnimatedSprite2D

var health = GameManager.health
var current_state = PlayerState.NORMAL
const DAMAGE_RATE = 5.0

func _ready() -> void:
	sprite.play("idle")
	sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta):
	if current_state == PlayerState.DYING:
		return
		
	handle_movement()
	handle_damage(delta)
	update_animation()

func handle_movement():
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	if direction.x != 0:
		sprite.flip_h = direction.x < 0

func handle_damage(delta):
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		if current_state != PlayerState.HURT:  # Only change state if not already hurt
			current_state = PlayerState.HURT
		%ProgressBar.value = health
		
		if health <= 0:
			handle_death()

func update_animation():
	var target_animation = get_target_animation()
	sprite.play(target_animation)  # Remove the comparison check

func get_target_animation() -> String:
	match current_state:
		PlayerState.HURT:
			return "hurt"
		PlayerState.DYING:
			return "die"
		_: # NORMAL state
			return "walk_right" if velocity != Vector2.ZERO else "idle"

func handle_death():
	current_state = PlayerState.DYING
	set_physics_process(false)
	print("Player Died")
	sprite.stop()
	sprite.play("die")

func _on_animation_finished():
	match sprite.animation:
		"die":
			print("Die Completed - emitting health depleted")
			health_depleted.emit()
		"hurt":
			print("Hurt Completed")
			current_state = PlayerState.NORMAL
			update_animation()  # Force immediate animation update
		_:
			print("Animation Finished: ", sprite.animation)
