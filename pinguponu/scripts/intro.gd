extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$play_button.menu_pressed.connect(_on_menu_pressed)
	$exit_button.menu_pressed.connect(_on_menu_pressed)
	
func _on_menu_pressed(action: String):
	match action:
		"play":
			get_tree().change_scene_to_file("res://levels/world_1.tscn")
		"exit":
			get_tree().quit()
