extends Node2D

func _ready():
	GameManager.victory.connect(_on_score_reached)

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://Scenes/enemy/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%Label.text = "GAME OVER: \nYou're dead..."
	%GameOver.show()
	%GameOver.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	get_tree().paused = true

func _on_score_reached():
	%Label.text = "VICTORY"
	%GameOver.show()
	%GameOver.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	get_tree().paused = true
	

func restart_game():
	print("Called Restart Game")
	GameManager.reset_game()
	get_tree().reload_current_scene()

func _on_play_again_button_pressed():
	print("Play again button pressed!")

	get_tree().paused = false
	%PlayAgainButton.disabled = true
	restart_game()
