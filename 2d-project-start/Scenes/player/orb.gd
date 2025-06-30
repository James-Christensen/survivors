extends Area2D

var target_enemy = null
@onready var animation_player = %AnimationPlayer

# Orbital movement variables
var orbit_radius = 130.0  # Distance from player
var orbit_speed = 2.0    # Rotation speed (radians per second)
var current_angle = 0.0  # Current angle around the player
@onready var player = get_parent()  # Assuming orb is child of player

func _ready():
	animation_player.play("default")
	# Set initial position
	update_orbital_position()

func _process(delta):
	# Update orbital movement
	current_angle += orbit_speed * delta
	update_orbital_position()
	
	# Find target enemy but don't snap rotation to it
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		target_enemy = get_closest_enemy(enemies_in_range)
	else:
		target_enemy = null

func update_orbital_position():
	# Calculate position around the player
	var offset = Vector2(cos(current_angle), sin(current_angle)) * orbit_radius
	global_position = player.global_position + offset

func get_closest_enemy(enemies: Array) -> Node2D:
	var closest_enemy = null
	var closest_distance = INF
	
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	
	return closest_enemy

func shoot():
	# Only shoot if we have a target
	if target_enemy == null:
		return
		
	const BULLET = preload("res://Scenes/player/bolt.tscn")
	var new_bullet = BULLET.instantiate()
	
	# Calculate direction to target enemy
	var direction_to_target = (target_enemy.global_position - %ShootingPoint.global_position).normalized()
	
	# Set bullet position and rotation to aim at enemy
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.rotation = direction_to_target.angle()
	
	# Add bullet to scene (not as child of orb to avoid moving with orb)
	get_tree().current_scene.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
