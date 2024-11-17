class_name GetBalls
extends Control

const MESSAGE_WIN := "Take those for your journey..."

const MAIN_MENU = "res://scenes/menu.tscn"

@onready var label: Label = %Message
@onready var continue_button: Button = %MainMenuButton

func _ready() -> void:
	Pegballs.add_ball();
	Pegballs.add_ball();
	Pegballs.add_ball();
	Pegballs.add_ball();
	
	continue_button.pressed.connect(func(): Events.room_cleared.emit())
