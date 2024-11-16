extends Node2D

# Array mit den Musikdateien

@onready var audio_player = $Music
var music_tracks = [] 

# Wird aufgerufen, wenn die Szene geladen wird
func _ready() -> void:
	# Musikdateien in das Array laden
	music_tracks = [
		preload("res://Music/LevelMusikREAL.wav"),
		preload("res://Music/PeggLevelTypShitReal.wav"),
		preload("res://Music/PeggEndBossTypeshit.wav")
		]

	# Zufällige Musik auswählen und abspielen
	play_random_music()

func play_random_music() -> void:
	# Wähle einen zufälligen Track aus dem Array
	var random_index = randi() % music_tracks.size()
	audio_player.stream = music_tracks[random_index]
	audio_player.play()
	
	
