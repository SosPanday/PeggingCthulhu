extends Node2D

@onready var music: AudioStreamPlayer2D = $Music
@onready var score_label: Label = $UserInterface/ScoreLabel
@export var highscore_threshold: int = 50  # Highscore-Schwelle
@export var ball_scene: PackedScene
@export var spawn_position: Vector2 = Vector2(100, 100)

var music_tracks = []  # Liste der Musikdateien
var score = 0  # Punktestand

func _ready():	
	# Musikdateien ins Array laden
	music_tracks = [
		preload("res://Music/SongFürNachUnten.wav"),
		preload("res://Music/PlayboIcarly.wav"),
		preload("res://Music/LevelMusikREAL.wav"),
		preload("res://Music/PeggLevelTypShitReal.wav"),
		preload("res://Music/PeggEndBossTypeshit.wav"),
		preload("res://Music/EndBoss.wav"),
		preload("res://Music/SongFürNachUnten.wav")
	]
	play_random_music()  # Zufällige Musik abspielen

# Funktion, um eine neue Kugel zu erstellen
func _process(delta: float) -> void:
	var orbs_node = $Orbs
	var orb_count = orbs_node.get_child_count()

	if(orb_count == 0):
		readyToGoPeggle()

func create_ball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.global_position = spawn_position  # Kugel an Spawn-Position setzen
	add_child(ball_instance)  # Kugel zur Szene hinzufügen

# Wird ausgelöst, wenn der Button losgelassen wird
func _on_button_spawn_button_up() -> void:
	print("button up")
	create_ball()

# Zufällige Musik abspielen
func play_random_music() -> void:
	if music_tracks.size() > 0:
		var random_index = randi() % music_tracks.size()
		music.stream = music_tracks[random_index]
		music.play()
	else:
		print("Keine Musikdateien vorhanden!")

func update_score_display():
 	
	if score_label:
		score_label.text = "Score: %s" % score
	else:
		print("Score-Label nicht gefunden!")

# Highscore erreicht
func _on_user_interface_score_updated(new_score: Variant) -> void:
	score = new_score  # Punktestand aktualisieren
	update_score_display()
	if score >= highscore_threshold:
		print("Highscore erreicht! Punktestand: %s" % score)

func readyToGoPeggle():
	print("RAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUSRAUS")
