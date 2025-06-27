extends Node

signal score_changed(new_score)
signal victory()

var score: int = 0
var victory_score: int = 1000
var health = 100.0


func add_score(points: int):
	score += points
	if score >= victory_score:
		score_changed.emit(score)
		victory.emit()
	else:
		score_changed.emit(score)

func reset_score():
	score = 0
	score_changed.emit(score)
	

func reset_game():
	score = 0
	health = 100.0
	score_changed.emit(score)
