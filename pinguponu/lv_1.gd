extends Node

@onready var spawn_point: Node3D = $"../../ball_sp1"
@onready var ball_container: Node3D = $"../../balls"

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	print("spawn")
	
	spawn_ball()

func spawn_ball() -> void:
	var ball_scene = preload("res://Entities/balls.tscn")
	var ball := ball_scene.instantiate()
	ball.global_position = Vector3(0,4,0)
	add_child(ball)
