extends Area2D

var target_enemy = null

func _process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		target_enemy = get_closest_enemy(enemies_in_range)
		look_at(target_enemy.global_position)
	else:
		target_enemy = null

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
		
	const BULLET = preload("res://Scenes/player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
