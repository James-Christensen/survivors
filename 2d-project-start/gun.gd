extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		print("Enemies in Range")
		var target_enemy = enemies_in_range.front()
		print("target_enemy found")
		look_at(target_enemy.global_position)
