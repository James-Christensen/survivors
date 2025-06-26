extends CharacterBody2D

@onready var happy = $HappyBoo


func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		happy.play_walk_animation()
	else: 
		happy.play_idle_animation()
