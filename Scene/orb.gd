extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal orb_collected

func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	# Check if the colliding body is the ball
	if body.is_in_group("ball"):
		print("orb collected")
		emit_signal("orb_collected")  # Notify that the orb was collected
		queue_free()  # Remove the orb from the scene
