extends Control

const RUN_SCENE = preload("res://scenes/run/run.tscn")

@export var run_startup: RunStartup

@onready var continue_button: Button = %Continue


func _ready() -> void:
	get_tree().paused = false
	continue_button.disabled = SaveGame.load_data() == null


func _on_continue_pressed() -> void:
	if run_startup == null:
		run_startup = RunStartup.new()
		
	Global.run_startup = run_startup
	run_startup.type = RunStartup.Type.CONTINUED_RUN
	get_tree().change_scene_to_packed(RUN_SCENE)


func _on_new_run_pressed() -> void:
	if run_startup == null:
		run_startup = RunStartup.new()
		
	print("Start new Run with")
	run_startup.type = RunStartup.Type.NEW_RUN
	get_tree().change_scene_to_packed(RUN_SCENE)



func _on_exit_pressed() -> void:
	get_tree().quit()
