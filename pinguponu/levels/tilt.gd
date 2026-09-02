extends Node3D

@export var max_rotation := 25.0
@export var smoothness := 5.0

func _process(delta: float) -> void:
	var viewport_size := get_viewport().get_visible_rect().size
	var midpoint_x := viewport_size.x / 2.0
	var midpoint_y := viewport_size.y / 4.0
	var mouse_x := get_viewport().get_mouse_position().x
	var mouse_y := get_viewport().get_mouse_position().y

	var mouse_offset_x := (mouse_x - midpoint_x) / midpoint_x
	mouse_offset_x = clamp(mouse_offset_x, -1.0, 1.0)
	var target_rotation_z := deg_to_rad(max_rotation) * mouse_offset_x
	
	rotation.z = lerp(
		rotation.z,
		-target_rotation_z,
		1.0 - exp(-smoothness * delta)
	)
