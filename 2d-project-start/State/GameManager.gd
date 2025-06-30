extends Node

signal score_changed(new_score)
signal victory()

var score: int = 0
var victory_score: int = 1000
var last_upgrade_threshold: int = 0  # Track upgrades


#PLayer info
var health = 100.0
var damage_amount = 0
var max_damage_amount = 3

#Bullet
var bullet_speed = 1000
var max_bullet_speed = 2000
var bullet_range = 1200
var max_bullet_range = 2400

func add_score(points: int):
	score += points

	# Check for gun upgrades every 50 points
	var new_upgrade_threshold = score / 50
	print("Threshold:")
	print(new_upgrade_threshold)

	if new_upgrade_threshold > last_upgrade_threshold:
		print("Gun Upgrading")
		upgrade_gun()
		last_upgrade_threshold = new_upgrade_threshold
	
	if score >= victory_score:
		score_changed.emit(score)
		victory.emit()
	else:
		score_changed.emit(score)

func reset_score():
	score = 0
	last_upgrade_threshold = 0  # Reset upgrade tracking
	score_changed.emit(score)
	
func reset_game():
	print("GM reset game")

	health = 100.0
	reset_score()

func upgrade_gun():
	if damage_amount <= max_damage_amount:
		damage_amount += 1
	if bullet_range <= max_bullet_range:
		bullet_range += 100
	if bullet_speed <= max_bullet_speed:
		bullet_speed += 100
	
	print("Weapon Stats:")
	print(damage_amount)
	print(bullet_range)
	print(bullet_speed)
