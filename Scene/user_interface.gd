extends Control

var score = 0

@onready var score_label: Label = $ScoreLabel

func increase_score(points: int = 1):
	score += points
	update_score_display()

func update_score_display():
	if score_label:
		score_label.text = "Score: %s" % score
