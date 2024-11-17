extends Node

@export var ball: PackedScene
@export var offset: float = 1.0
@export var fire_rate: float = 1.0
var last_fire: float = 0.0

func _ready():
	last_fire = fire_rate

func _process(delta):
	last_fire += delta

	# Überprüfen, ob die Bedingungen für den Schuss erfüllt sind
	if Pegballs.balls > 0 and Input.is_action_pressed("left_mouse") and last_fire >= fire_rate:
		# Timer zurücksetzen
		last_fire = 0

		# Instanziere die Kugel (Ball)
		var oball: Node2D = ball.instantiate() as Node2D
		oball.position = get_parent().position - (-get_parent().global_transform.y) * offset

		# Füge die Kugel zur Szene hinzu
		get_tree().root.add_child(oball)

		# Reduziere die Anzahl der verfügbaren Bälle
		Pegballs.remove_ball()

		# Wende einen Impuls auf die Kugel an
		if oball is RigidBody2D:
			(oball as RigidBody2D).apply_central_impulse(get_parent().global_transform.y * 100)
