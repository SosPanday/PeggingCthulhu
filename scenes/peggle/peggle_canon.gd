extends Node2D

# Min und Max Winkel in Radiant
const MIN_ROTATION = -PI / 2  # -90°
const MAX_ROTATION = PI / 2   # 90°

func _ready():
	pass

func _process(delta):
	# Position der Maus in der 2D-Welt
	var world_mouse_pos = get_global_mouse_position()

	# Position der Maus relativ zum Objekt
	var relative_pos = world_mouse_pos - position

	# Berechnung der Rotation
	var rotation_z = atan2(relative_pos.y, relative_pos.x)

	# Clamping der Rotation
	rotation = clamp(rotation_z - PI / 2, MIN_ROTATION, MAX_ROTATION)
