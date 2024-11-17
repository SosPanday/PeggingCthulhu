class_name RoomCleared
extends Control

const MESSAGE_WIN := "You've cleared this room\nDoom is inevitible. \n You come closer"
const MESSAGE_LOSE := "You failed... \n Now perish"
const MAIN_MENU = "res://scenes/ui/main_menu.tscn"

enum Type {WIN, LOSE}

# Set the type of the message (WIN or LOSE)
var message_type: Type = Type.WIN

@onready var label: Label = %Message
@onready var continue_button: Button = %MainMenuButton
@onready var main_menu_button: Button = %MainMenuButton2

func _ready() -> void:
	continue_button.pressed.connect(func(): Events.room_cleared.emit())
	main_menu_button.pressed.connect(get_tree().change_scene_to_file.bind(MAIN_MENU))
	
	update_message()
	
# Function to update the message in the label
func update_message() -> void:
	match message_type:
		Type.WIN:
			label.text = MESSAGE_WIN
		Type.LOSE:
			label.text = MESSAGE_LOSE
