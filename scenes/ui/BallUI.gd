extends AnimatedSprite2D

func _ready():
	# Initiale Verbindung zum Signal von CompterBall
	Pegballs.connect("ball_count_changed", Callable(self, "_on_ball_count_changed"))

	
	# Setze den ersten Frame basierend auf der Anfangszahl der Bälle
	update_frame(Pegballs.balls)

func _on_ball_count_changed(new_count):
	# Wenn sich die Anzahl der Bälle ändert, aktualisiere das Frame
	update_frame(new_count)

# Diese Methode setzt das richtige Frame
func update_frame(ball_count: int):
	# Clamp ball_count auf den Bereich von 0 bis 12, da du 12 Frames hast
	frame = clamp(ball_count, 0, 12 - 1)  # Maximaler Frameindex ist 11, da Indizes bei 0 beginnen
