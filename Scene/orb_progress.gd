extends Node2D

@onready var music: AudioStreamPlayer2D = $Music
@onready var score_label: Label = $UserInterface/ScoreLabel
@export var highscore_threshold: int = 50  # Highscore-Schwelle
@onready var audio_player = $Music
@export var ball_scene: PackedScene
@export var spawn_position: Vector2 = Vector2(100, 100)
@export var offset: float = 1.0
@export var fire_rate: float = 1.0
var last_fire: float = 0.0
var music_tracks = [] 

var score = 0  # Punktestand

func _ready():
	# Musikdateien ins Array laden
	last_fire = fire_rate
	music_tracks = [
		preload("res://Music/SongFürNachUnten.wav"),
		preload("res://Music/PlayboIcarly.wav"),
		preload("res://Music/LevelMusikREAL.wav"),
		preload("res://Music/PeggLevelTypShitReal.wav"),
		preload("res://Music/PeggEndBossTypeshit.wav"),
		preload("res://Music/EndBoss.wav"),
		preload("res://Music/SongFürNachUnten.wav")
		]
	play_random_music()
	


func _process(delta):
	last_fire += delta

	if Pegballs.balls > 0 and Input.is_action_pressed("left_mouse") and last_fire >= fire_rate:
		# Timer zurücksetzen
		last_fire = 0

		# Instanziere die Kugel (Ball)
		var ball_instance = ball_scene.instantiate()
		ball_instance.global_position = spawn_position  # Ball zur Szene hinzufügen
		add_child(ball_instance)
		# Reduziere die Anzahl der verfügbaren Bälle
		Pegballs.remove_ball()
	


	
func _on_button_spawn_button_up() -> void:
	print("button up")

func play_random_music() -> void:
	var random_index = randi() % music_tracks.size()
	audio_player.stream = music_tracks[random_index]
	audio_player.play()

func increase_score(points: int = 1):
	score += points  # Punkte hinzufügen
	update_score_display()
	highscore_reached()  # Highscore prüfen

func update_score_display():
	if score_label:
		score_label.text = "Score: %s" % score

func highscore_reached():
	if score >= highscore_threshold:
		print("Highscore reached!")
		# Optional: Zusätzliche Aktionen hier hinzufügen


func _on_user_interface_score_updated(new_score: Variant) -> void:
	print("Highscore erreicht! Punktestand: %s" % new_score)
