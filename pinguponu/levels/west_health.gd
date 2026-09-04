extends MeshInstance3D

@export var max_health: float = 100.0

signal is_dead
var original_scale: Vector3
var current_health: float
var dead: bool = false

func _ready() -> void:
	original_scale = scale
	current_health = max_health

	var damage = get_node("../../../Westwood")
	damage.damage.connect(_shrink_by)

func _shrink_by(damage_amount: float, duration: float = 0.1) -> void:
	current_health = max(0.0, current_health - damage_amount)
	var health_percent = current_health / max_health

	var target_z = original_scale.z * health_percent
	var tween = create_tween()
	tween.tween_property(self, "scale:z", target_z, duration)
	if current_health <= 0.0:
		dead = true
		is_dead.emit()
