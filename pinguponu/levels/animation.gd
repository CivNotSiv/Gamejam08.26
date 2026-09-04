extends Node3D


@onready var idle: MeshInstance3D = $idle
@onready var charge: MeshInstance3D = $charge
@onready var strike: MeshInstance3D = $strike

@export var ball_scene: PackedScene = preload("res://Entities/balls.tscn")
@onready var spawn_point: Node3D = $SpawnPoint
@onready var ball_container: Node3D = $balls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charge.visible = false
	strike.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_ball(velocity: float) -> void:
	var ball := ball_scene.instantiate()
	ball_container.add_child(ball)

	ball.global_position = spawn_point.global_position
	
	var body: RigidBody3D = ball.get_node("basic2")
	body.linear_velocity = Vector3(velocity, 0, 0)


func attack(charge_time: float, recovery: float, velocity: float):
	idle.visible = false
	charge.visible = true
	await get_tree().create_timer(charge_time).timeout
	charge.visible = false
	strike.visible = true
	spawn_ball(velocity)
	await get_tree().create_timer(recovery).timeout
	strike.visible = false
	idle.visible = true
