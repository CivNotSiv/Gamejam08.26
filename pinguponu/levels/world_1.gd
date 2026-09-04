extends Node

@onready var timer: Timer = $SpawnTimer
@onready var boss: Node3D = $Westwood
	
@onready var pause_menu: Node3D = $pause_menu
@onready var camera: Camera3D = $Player_data/Anchor/Camera3D
@onready var anchor: Node3D = $Player_data/Anchor
@onready var environment: Environment = $WorldEnvironment.environment

@export var ball_scene: PackedScene = preload("res://Entities/balls.tscn")

var default_anchor_transform: Transform3D
var pause_fog: float = 0.3451
var default_fov: float
var base_x: float
var move_tween: Tween

func _ready() -> void:
	base_x = boss.position.z
	camera.environment.volumetric_fog_density = 0.0
	$"ceiling lights".light_energy = 1.76
	$"./Health/Westwood/west_health".is_dead.connect(_end_scene)
	default_anchor_transform = anchor.transform
	default_fov = camera.fov
	timer.timeout.connect(_on_timeout)
	timer.start(3)

func _on_timeout() -> void:
	boss.attack(1, 0.2, 30)
	var target_x = base_x + randf_range(-3, 3)

	move_tween = create_tween()
	move_tween.set_trans(Tween.TRANS_SINE)
	move_tween.set_ease(Tween.EASE_IN_OUT)
	move_tween.tween_property(boss, "position:z", target_x, 1)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

@export var change_speed: float = 1.0
var current_value: float = 0.0


func _end_scene():
	timer.stop()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera.environment, "volumetric_fog_density", 0.3451, 5)
	tween.tween_property($"ceiling lights", "light_energy", 6, 5)

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	if pause_menu.visible == true:
		anchor.transform = default_anchor_transform
		camera.fov = default_fov
		#camera.environment.volumetric_fog_density = pause_fog
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
