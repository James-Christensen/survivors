extends Node2D
@onready var spawn_timer =  %Timer # Reference to your Timer node

func	 _ready():
	# Configure the timer
	spawn_timer.wait_time = 3.0  # Spawn every 2 seconds
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	
func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
