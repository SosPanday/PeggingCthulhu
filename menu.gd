extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game_proto.tscn")
	
	


func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://how_to_play.tscn")
	
	


func _on_quit_pressed() -> void:
	get_tree().quit()
