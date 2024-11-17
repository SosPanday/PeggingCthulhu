class_name Run
extends Node

const HIGHSCORE_SCENE := preload("res://Scene/LevelWithHighscore.tscn")
const BREAK_SCENE := preload("res://BasicMap.tscn")

const ORB_SCENE := preload("res://BasicMap.tscn")
const PEGGLE_SCENE := preload("res://scenes/peggle/peggle_0.tscn")

const WIN_SCREEN_SCENE := preload("res://scenes/win_screen/win_screen.tscn")
const ROOM_CLEAR_SCENE := preload("res://scenes/ui/room_cleared.tscn")
const GET_BALLS := preload("res://scenes/ui/get_balls.tscn")
const MAIN_MENU_PATH := "res://scenes/menu.tscn"

var run_startup = Global.run_startup

@onready var map: Map = $Map
@onready var current_view: Node = $CurrentView

@onready var pause_menu: PauseMenu = $PauseMenu

@onready var battle_button: Button = %BattleButton
@onready var campfire_button: Button = %CampfireButton
@onready var map_button: Button = %MapButton
@onready var enemy_button: Button = %EnemyButton
@onready var shop_button: Button = %ShopButton
@onready var treasure_button: Button = %TreasureButton

var save_data: SaveGame


func _ready() -> void:
	if run_startup == null:
		run_startup = RunStartup.new()
	if not run_startup:
		return
	
	pause_menu.save_and_quit.connect(
		func(): 
			get_tree().change_scene_to_file(MAIN_MENU_PATH)
	)
	
	match run_startup.type:
		RunStartup.Type.NEW_RUN:
			_start_run()
			print("run_startup is null:", run_startup == null)
		RunStartup.Type.CONTINUED_RUN:
			_load_run()
			print("run_startup is null:", run_startup == null)
	


func _start_run() -> void:
	
	_setup_event_connections()
	
	map.generate_new_map()
	map.unlock_floor(0)
	
	save_data = SaveGame.new()
	_save_run(true)


func _save_run(was_on_map: bool) -> void:
	save_data.rng_seed = RNG.instance.seed
	save_data.rng_state = RNG.instance.state
	save_data.last_room = map.last_room
	save_data.map_data = map.map_data.duplicate()
	save_data.floors_climbed = map.floors_climbed
	save_data.was_on_map = was_on_map
	save_data.save_data()


func _load_run() -> void:
	save_data = SaveGame.load_data()
	assert(save_data, "Couldn't load last save")
	
	RNG.set_from_save_data(save_data.rng_seed, save_data.rng_state)
	_setup_event_connections()
	
	map.load_map(save_data.map_data, save_data.floors_climbed, save_data.last_room)
	if save_data.last_room and not save_data.was_on_map:
		_on_map_exited(save_data.last_room)


func _change_view(scene: PackedScene) -> Node:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view)
	map.hide_map()
	
	return new_view


func _show_map() -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()

	map.show_map()
	map.unlock_next_rooms()
	
	_save_run(true)


func _setup_event_connections() -> void:
	#enemy_button.pressed.connect(_change_view.bind(ENEMY_SCENE))
	map_button.pressed.connect(_show_map)
	Events.map_exited.connect(_on_map_exited)
	Events.all_orbs_collected.connect(_on_room_cleared)
	Events.room_cleared.connect(_show_map)

	#battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(GET_BALLS))
	map_button.pressed.connect(_show_map)
	#enemy_button.pressed.connect(_change_view.bind(ENEMY_SCENE))
	#shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	treasure_button.pressed.connect(_change_view.bind(PEGGLE_SCENE))

func _on_room_entered() -> void:
	_change_view(ORB_SCENE)
	
func _on_room_cleared() -> void:
	if map.floors_climbed == MapGenerator.FLOORS:
		_change_view(WIN_SCREEN_SCENE)
		SaveGame.delete_data()
	else:
		_regular_room_clear()
		
func _regular_room_clear() -> void:
	_change_view(ROOM_CLEAR_SCENE)
	

# Liste von Leveln (Pfad zu den Szenen)
const levels = [
	"res://Scene/FirstLevel.tscn",
	"res://Scene/ErenLvL.tscn",
	"res://Scene/ErenLvL2.tscn"
]

const LEVEL1_SCENE := preload("res://Scene/FirstLevel.tscn")
const LEVEL2_SCENE := preload("res://Scene/ErenLvL.tscn")
const LEVEL3_SCENE := preload("res://Scene/ErenLvL2.tscn")


func load_random_level():
	# Randomisieren des Seeds (optional, für echte Zufälligkeit)
	randomize()
	# Wähle einen zufälligen Index aus der Level-Liste
	var random_index = randi() % levels.size()

	# Lade die zufällige Szene
	var level_path = levels[random_index]
	var level_scene = load(level_path)

	# Wechsle zu dieser Szene
	if level_scene:
		_change_view(level_scene)
	else:
		print("Fehler: Konnte Szene %s nicht laden!" % level_path)

	
func _on_map_exited(room: Room) -> void:
	print("Room is:", room.type)
	_save_run(false)
	
	match room.type:
		Room.Type.ORB:
			load_random_level()
		Room.Type.HIGHSCORE:
			_change_view(HIGHSCORE_SCENE)
		Room.Type.BREAK:
			_change_view(BREAK_SCENE)
		Room.Type.RELAX:
			_change_view(GET_BALLS)
		Room.Type.BOSS:
			_on_room_cleared()
			
