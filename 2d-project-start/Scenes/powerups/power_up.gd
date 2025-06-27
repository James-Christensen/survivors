class PowerUp
extends Area2D

func _ready() -> void:	
	print("Powerup ready - monitoring set to: ", monitoring)
	print("Powerup collision layer: ", collision_layer)
	print("Powerup collision mask: ", collision_mask)
	play_idle_animation()

func play_idle_animation():
	$AnimationPlayer.play("idle")
	
func play_pickup_animation():
	$AnimationPlayer.play("picked_up")

func _on_powerup_body_entered(body: Node2D) -> void:
	var smoke_scene = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = smoke_scene.instantiate()
	
	if body.name == "Player": 
		print("Picked Up") 
		play_pickup_animation()
		
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		GameManager.add_score(10)
		queue_free()
		queue_free()
