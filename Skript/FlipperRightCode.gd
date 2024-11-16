extends CharacterBody2D

# Eigenschaften für die Flipperbewegung
var angle_speed = 500.0  # Drehgeschwindigkeit in Grad/Sekunde
var min_angle = -30.0    # Minimale Flipper-Drehung (nach unten)
var max_angle = 30.0     # Maximale Flipper-Drehung (nach oben)
var direction = 0        # Rotationsrichtung: 1 = hoch, -1 = runter, 0 = still

# Status-Variable, um gedrückte Flipper zu tracken
var is_flipper_pressed = false

func _process(delta):
	# Bewegung der Flipper basierend auf der Richtung
	if direction != 0:
		rotation += deg_to_rad(direction * angle_speed * delta)
		rotation = clamp(rotation, deg_to_rad(min_angle), deg_to_rad(max_angle))
		# Stoppe Bewegung, wenn die Grenze erreicht ist
		if direction > 0 and rotation >= deg_to_rad(max_angle):
			direction = 0
		elif direction < 0 and rotation <= deg_to_rad(min_angle):
			direction = 0

	# Eingaben für Flipper überprüfen (nur für den rechten Flipper)
	handle_right_flipper_input()

# Funktion, die nur den rechten Flipper überprüft
func handle_right_flipper_input():
	# Überprüfen, ob der rechte Flipper gedrückt wird
	if self.name == "RightFlipper":
		if Input.is_action_pressed("flipper_right") and not is_flipper_pressed:
			print("Flipper Right Pressed")
			flip(1)  # Flipper nach oben
			is_flipper_pressed = true

		if Input.is_action_just_released("flipper_right") and is_flipper_pressed:
			print("Flipper Right Released")
			flip(-1)  # Flipper zurück nach unten
			is_flipper_pressed = false

# Flipperbewegung anpassen
func flip(direction_input):
	direction = direction_input
