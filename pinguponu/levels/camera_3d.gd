extends Camera3D

@export var tight_fov := 50.0
@export var wide_fov := 130.0
@export var fov_smoothness := 5.0

func _process(delta: float) -> void:
	var viewport_height := get_viewport().get_visible_rect().size.y
	var midpoint_y := viewport_height / 2.0
	var mouse_y := get_viewport().get_mouse_position().y

	var distance: float = abs(mouse_y - midpoint_y) / midpoint_y
	distance = clamp(distance, 0.0, 1.0)

	var target_fov: float = lerp(tight_fov, wide_fov, distance)

	fov = lerp(
		fov,
		target_fov,
		1.0 - exp(-fov_smoothness * delta)
	)
