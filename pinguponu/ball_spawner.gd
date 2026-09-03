extends Node

@export var ball_scene: PackedScene

@onready var spawn_point: Node3D = $"../world_1/Ball_spawn"
@onready var balls: Node3D = $"../balls"


func spawn_ball() -> void:
	var ball := ball_scene.instantiate()
	balls.add_child(ball)
	ball.global_position = spawn_point.global_position


func _on_timer_timeout() -> void:
	spawn_ball()
