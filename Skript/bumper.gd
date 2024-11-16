extends Node2D

@export var bump_force = 10  # Force applied to the ball on contact

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	print("wir haben Kontakt")
	if body is RigidBody2D and body.is_in_group("ball"):
		# Calculate the direction to push the ball
		var direction = (body.global_transform.get_origin() - global_transform.origin.normalized())
		# Apply an impulse to the ball
		body.apply_impulse(direction * bump_force)
