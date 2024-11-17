extends Node2D

@onready var audio_player = $Music
var music_tracks = [] 

@export var ball_scene:PackedScene
@export var spawn_position: Vector2 = Vector2(100, 100)
  # Default spawn position

@export var total_orbs = 21  # Total number of orbs in the level
var collected_orbs = 0  # Counter for collected orbs

func _ready():
		# Musikdateien in das Array laden
	music_tracks = [
		preload("res://Music/LevelMusikREAL.wav"),
		preload("res://Music/PeggLevelTypShitReal.wav"),
		preload("res://Music/PeggEndBossTypeshit.wav")
		]
	play_random_music()
	# Connect the orb_collected signal for each orb
	for orb in $Orbs.get_children():
		orb.connect("orb_collected", Callable(self, "_on_orb_collected"))
	# Set the initial value of the ProgressBar
	$ProgressBar.max_value = total_orbs
	$ProgressBar.value = collected_orbs
		
		
func _on_orb_collected():
	# Update the collected orbs counter
	collected_orbs += 1
	# Update the ProgressBar
	$ProgressBar.value = collected_orbs

	# Check if all orbs have been collected
	if collected_orbs == total_orbs:
		_on_all_orbs_collected()

func _on_all_orbs_collected():
	print("All orbs collected!")
	
	# Add additional logic for when all orbs are collected

func create_ball():
	var ball_instance = ball_scene.instantiate()
	ball_instance.global_position = spawn_position # Add the ball to the current scene
	add_child(ball_instance)
	
	
func _on_button_spawn_button_up() -> void:
	print("button up")
	create_ball()
func play_random_music() -> void:
	# Wähle einen zufälligen Track aus dem Array
	var random_index = randi() % music_tracks.size()
	audio_player.stream = music_tracks[random_index]
	audio_player.play()
	
