extends RigidBody2D 

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit")
	var main_scene = get_parent()
	if main_scene and main_scene.name == "FirstLevel":
		
		print("HEHEHEHEHEH") 
		 # Sicherstellen, dass es die richtige Node ist
		var control_node = main_scene.get_node("UserInterface")
		if is_direct_hit(body):
			var camera_node = main_scene.get_node("Camera2D") as Camera2D
			if camera_node and camera_node.has_method("start_shake"):
				camera_node.start_shake(3.5, 0.2)  # Intensität: 10, Dauer: 0.5 Sekunden
		

		if control_node:
			control_node.increase_score(5)
	
	if body.has_method("damage"):
		print("loeschMich")
		body.damage()
func is_direct_hit(body: Node2D) -> bool:
	# Nur bei Kollisionen mit hoher Geschwindigkeit
	if linear_velocity.length() > 200:  # Passe die Geschwindigkeitsschwelle an
		print("Direkter Treffer!")	
		return true
	return false
