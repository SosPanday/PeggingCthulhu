extends StaticBody2D

# Lebenspunkte des Würfels
var lives = 3  # Der Würfel hat anfangs 3 Leben

# Funktion, die beim Kollisionseintritt des Balls aufgerufen wird
func _on_Wuerfel_body_entered(body):
	if body.is_in_group("Ball"):  # Nur wenn es der Ball ist
		lives -= 1  # Reduziere das Leben des Würfels
		print("Würfel hat jetzt", lives, "Leben")

		# Optional: Feedback (z. B. bei 0 Leben den Würfel entfernen)
		if lives <= 0:
			queue_free()  # Entferne den Würfel, wenn keine Leben mehr vorhanden sind
