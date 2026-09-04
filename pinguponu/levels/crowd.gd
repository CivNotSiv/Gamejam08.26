extends Node3D
class_name Crowd

@export var base_bob_height: float = 0.5
@export var base_bob_speed: float = 1.0
@export var max_intensity: float = 2.0
@export var intensity_decay: float = 0.75      

var meshes: Array[MeshInstance3D] = []
var base_positions: Array[Vector3] = []
var phase_offsets: Array[float] = []

var intensity: float = 0.0

func _ready() -> void:
	for child in get_children():
		if child is MeshInstance3D:
			meshes.append(child)
			base_positions.append(child.position)
			phase_offsets.append(randf() * TAU)
	var manager = get_node("../player")
	manager.crowd_jump.connect(_on_player_jump)
	var damage = get_node("../Westwood")
	damage.crowd_jump.connect(_on_damage_jump)

func _process(delta: float) -> void:
	intensity = max(0.0, intensity - intensity_decay * delta)
	var t := Time.get_ticks_msec() / 1000.0
	for i in meshes.size():
		var mesh = meshes[i]
		var base_pos = base_positions[i]
		var phase = phase_offsets[i]

		var height = base_bob_height + intensity * 0.3
		var speed = 4

		var bob = absf(sin(t * speed + phase)) * height
		mesh.position.y = base_pos.y + bob

func _on_player_jump(jump_boost: float) -> void:
	intensity = min(max_intensity, intensity + jump_boost)

func _on_damage_jump(jump_boost: float) -> void:
	var remaining = max_intensity - intensity
	intensity += jump_boost * 1.5 * (remaining / max_intensity)
