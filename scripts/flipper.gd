extends CharacterBody2D

@export var is_left_flipper = true  # Indicates whether this is the left flipper
var flipper_speed = 20  # Speed of the flipper
var max_angle = 0.5  # Maximum rotation angle (in radians)

func _process(delta):
	if is_left_flipper:
		# Control for the left flipper
		if Input.is_action_pressed("flipper_left"):
			rotation -= flipper_speed * delta
		else:
			rotation += flipper_speed * delta
	else:
		# Control for the right flipper
		if Input.is_action_pressed("flipper_right"):
			rotation += flipper_speed * delta
		else:
			rotation -= flipper_speed * delta

	# Clamp the rotation to the allowed range
	rotation = clamp(rotation, -max_angle, max_angle)
