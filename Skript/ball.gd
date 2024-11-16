# Ball-Skript (RigidBody2D)
extends RigidBody2D

# Überprüfe die Kollision mit dem Würfel und ziehe Leben ab
func _on_Ball_body_entered(body):
	if body.is_in_group("static_boxes"):  # Überprüfen, ob der Ball mit einem Würfel kollidiert
		body.take_damage(1)  # Schaden am Würfel (wir reduzieren sein Leben um 1)
		print("Ball kollidierte mit dem Würfel! Leben des Würfels: ", body.lives)
