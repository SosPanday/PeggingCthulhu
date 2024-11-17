class_name WinScreen
extends Control

const MAIN_MENU_PATH = "res://scenes/menu.tscn"
const MESSAGE := "Dread falls where you go \n You've cleared the game."


@onready var message: Label = %Message

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
