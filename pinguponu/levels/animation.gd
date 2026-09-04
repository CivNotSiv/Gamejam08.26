extends Node3D
signal crowd_jump
signal damage

@onready var idle: MeshInstance3D = $idle
@onready var charge: MeshInstance3D = $charge
@onready var strike: MeshInstance3D = $strike

@export var ball_scene: PackedScene = preload("res://Entities/balls.tscn")
@onready var spawn_point: Node3D = $SpawnPoint
@onready var ball_container: Node3D = $balls

@export var bounce_height: float = 0.5
@export var bounce_speed: float = 8.0
@export var fall_angle: float = 90.0
@export var fall_duration: float = 0.6

var intensity: float = 0.0
var base_pos: float
var can_hit: bool = true


func _ready() -> void:
	base_pos = position.y
	charge.visible = false
	strike.visible = false
	$Area3D.body_entered.connect(_on_body_entered)
	$"../Health/Westwood/west_health".is_dead.connect(_death_animation)


func _death_animation():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation:x", deg_to_rad(-fall_angle), fall_duration)


func spawn_ball(velocity: float) -> void:
	var ball := ball_scene.instantiate()
	ball_container.add_child(ball)
	ball.global_position = spawn_point.global_position

	var options := ["basic2", "evil4"]
	var chosen_name: String = options[randi() % options.size()]
	for name in options:
		if name != chosen_name:
			ball.get_node(name).queue_free()

	var body: RigidBody3D = ball.get_node(chosen_name)
	body.linear_velocity = Vector3(velocity, -1, 0)


func _on_body_entered(body: Node3D) -> void:
	if not can_hit:
		return
	can_hit = false
	_on_hit()
	damage.emit(30)
	crowd_jump.emit(1)
	var ch_mat := idle.material_override as StandardMaterial3D
	var st_mat := strike.material_override as StandardMaterial3D
	var id_mat := idle.material_override as StandardMaterial3D
	id_mat.emission_enabled = true
	st_mat.emission_enabled = true
	ch_mat.emission_enabled = true
	await get_tree().create_timer(0.5).timeout
	id_mat.emission_enabled = false
	st_mat.emission_enabled = false
	ch_mat.emission_enabled = false
	can_hit = true
	
func _on_hit() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", base_pos + bounce_height, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", base_pos, 0.15).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

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
