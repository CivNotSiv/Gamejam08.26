extends Node

@onready var spawn_point: Node3D = $SpawnPoint
@onready var timer: Timer = $SpawnTimer
@onready var ball_container: Node3D = $"../balls"

@export var ball_scene: PackedScene = preload("res://Entities/balls.tscn")


func _ready() -> void:
	spawn_ball()
	timer.timeout.connect(_on_timeout)
	timer.start()


func _on_timeout() -> void:
	spawn_ball()


func spawn_ball() -> void:
	var ball := ball_scene.instantiate()
	ball_container.add_child(ball)
	ball.global_position = spawn_point.global_position
	
	var body: RigidBody3D = ball.get_node("basic2")
	body.linear_velocity = Vector3(20, -2, 0)
