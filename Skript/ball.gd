extends RigidBody2D 

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit")
	
	# Direkt zur Parent-Node greifen
	var main_scene = get_parent()
	if main_scene and main_scene.name == "PinBallTable":
		print("HEHEHEHEHEH")  # Sicherstellen, dass es die richtige Node ist
		var control_node = main_scene.get_node("UserInterface")
		if control_node:
			control_node.increase_score(5)
	
	if body.has_method("damage"):
		print("loeschMich")
		body.damage()
