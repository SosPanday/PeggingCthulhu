extends CharacterBody2D

# Eigenschaften für die Flipperbewegung
var angle_speed = 500.0  # Drehgeschwindigkeit in Grad/Sekunde
var min_angle = -20.0    # Minimale Flipper-Drehung (nach unten)
var max_angle = 12.0     # Maximale Flipper-Drehung (nach oben)
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

	# Eingaben für Flipper überprüfen
	handle_flipper_input()

func handle_flipper_input():
	# Beispiel: Links-Flipper
	if self.name == "LeftFlipper":
		if Input.is_action_pressed("flipper_left") and not is_flipper_pressed:
			flip(-1)  # Flipper nach oben
			is_flipper_pressed = true

		if Input.is_action_just_released("flipper_left") and is_flipper_pressed:
			flip(1)  # Flipper zurück nach unten
			is_flipper_pressed = false

	

func flip(direction_input):
	direction = direction_input
