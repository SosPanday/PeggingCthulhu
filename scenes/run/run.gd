class_name Run
extends Node

const CAMPFIRE_SCENE := preload("res://BasicMap.tscn")
const MAIN_MENU_PATH := "res://scenes/ui/main_menu.tscn"

var run_startup = Global.run_startup

@onready var map: Map = $Map
@onready var current_view: Node = $CurrentView

@onready var pause_menu: PauseMenu = $PauseMenu

@onready var battle_button: Button = %BattleButton
@onready var campfire_button: Button = %CampfireButton
@onready var map_button: Button = %MapButton
@onready var rewards_button: Button = %RewardsButton
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
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_show_map)

func _on_room_entered() -> void:
	_change_view(CAMPFIRE_SCENE)


func _on_map_exited(room: Room) -> void:
	_save_run(false)
	
	match room.type:
		Room.Type.ENEMY:
			_on_room_entered()
		Room.Type.KEYLOCK:
			_on_room_entered()
		Room.Type.CHARGE:
			_on_room_entered()
		Room.Type.RELAX:
			_on_room_entered()
		Room.Type.BOSS:
			_on_room_entered()
