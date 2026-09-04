extends Node

@onready var spawn_point: Node3D = $SpawnPoint
@onready var timer: Timer = $SpawnTimer
@onready var ball_container: Node3D = $"../balls"
@onready var pause_menu: Node3D = $pause_menu
@onready var camera: Camera3D = $Player_data/Anchor/Camera3D
@onready var anchor: Node3D = $Player_data/Anchor

@export var ball_scene: PackedScene = preload("res://Entities/balls.tscn")

var default_anchor_transform: Transform3D
var default_fov: float

func _ready() -> void:
	default_anchor_transform = anchor.transform
	default_fov = camera.fov
	#spawn_ball()
	#timer.timeout.connect(_on_timeout)
	#timer.start()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()


func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	if pause_menu.visible == true:
		anchor.transform = default_anchor_transform
		camera.fov = default_fov
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
#
#
#func _on_timeout() -> void:
	#spawn_ball()


#func spawn_ball() -> void:
	#var ball := ball_scene.instantiate()
	#ball_container.add_child(ball)
	#ball.global_position = spawn_point.global_position
	#
	#var body: RigidBody3D = ball.get_node("basic2")
	#body.linear_velocity = Vector3(20, -2, 0)
