extends Label

func _ready():
	# Verbindung zum Signal von CompterBall
	Pegballs.connect("ball_count_changed", Callable(self, "_on_ball_count_changed"))

	# Initialen Ballwert setzen
	text = "Balls: %d" % Pegballs.balls

func _on_ball_count_changed(new_count: int):
	text = "Balls: %d" % new_count
