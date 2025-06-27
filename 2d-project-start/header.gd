extends PanelContainer
@onready var score_label = %Score_Label

func _ready():
	GameManager.score_changed.connect(_on_score_changed)
	_on_score_changed(GameManager.score)

func _on_score_changed(new_score: int):
	score_label.text = "Score: " + str(new_score)
