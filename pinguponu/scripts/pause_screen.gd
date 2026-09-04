extends Node3D


@onready var continue_game = $continue_button
@onready var restart_stage = $restart_stage_button
@onready var main_menu = $main_menu_button

func _ready():
	continue_game.menu_pressed.connect(_on_menu_pressed)
	restart_stage.menu_pressed.connect(_on_menu_pressed)
	main_menu.menu_pressed.connect(_on_menu_pressed)


func _on_menu_pressed(action: String):
	match action:
		"continue":
			get_tree().paused = false
			visible = false
		"restart_stage":
			get_tree().paused = false
			get_tree().reload_current_scene()
		"main_menu":
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Intro.tscn")
			
