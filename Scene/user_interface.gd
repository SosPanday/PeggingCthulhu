extends Control

var score = 0  # Aktueller Punktestand

@onready var score_label: Label = $ScoreLabel

# Signal für Highscore-Ereignis
signal score_updated(new_score)

func increase_score(points: int = 1):
	score += points
	if score >= 250:  # Highscore-Bedingung
		emit_signal("score_updated", score)  # Signal auslösen
	update_score_display()

func update_score_display():
	if score_label:
		score_label.text = "Score: %s" % score
