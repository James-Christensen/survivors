extends Area2D

func _physics_process(delta):
	var all_areas = get_overlapping_areas()
	print("Total overlapping areas: ", all_areas.size())
	for area in all_areas:
		print("Found area: ", area.name)
	
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		print("Enemies in Range")
		var target_enemy = enemies_in_range.front()
		print("target_enemy found")
		look_at(target_enemy.global_position)


func _ready():
	# Enable collision shape visibility
	for child in get_children():
		if child is CollisionShape2D:
			child.debug_color = Color.RED
