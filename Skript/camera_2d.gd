extends Camera2D

var shake_intensity: float = 0.0
var shake_duration: float = 0.0
var original_offset: Vector2 = Vector2.ZERO
@onready var hit_sound_player = get_parent().get_node("HitSound")
@onready var hit_sound = preload("res://Music/Sfx/hitHurt(2).wav")  # Pfad zum Hit-Sound

# Wird aufgerufen, wenn die Szene geladen wird
func _ready() -> void:
	original_offset = offset

# Shake-Effekt aktivieren
func start_shake(intensity: float, duration: float) -> void:
	shake_intensity = intensity
	shake_duration = duration
	
	print(hit_sound_player)
	# Hit-Sound nur abspielen, wenn er nicht bereits läuft
	if hit_sound_player and !hit_sound_player.playing:
		print("playSoubd")
		hit_sound_player.stream = hit_sound
		hit_sound_player.play()  # Setze den Sound in den AudioStreamPlayer
		 # Starte den Sound

# Update für den Shake
func _process(delta: float) -> void:
	if shake_duration > 0:
		shake_duration -= delta
		offset = original_offset + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		# Zurück zur Originalposition
		offset = original_offset
