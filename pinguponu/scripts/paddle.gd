extends Node3D

#@export var paddle: Node3D
@export var min_x := 1.7
@export var max_x := 4.0
@export var min_z := -3.7
@export var max_z := 3.7

func _physics_process(delta: float) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	var cam := get_node("../Camera3D") as Camera3D
	var mousepos := get_viewport().get_mouse_position()
	var origin_ray : Vector3 = cam.project_ray_origin(mousepos)
	var direction : Vector3 = cam.project_ray_normal(mousepos)
	
	var plane := Plane(Vector3.UP)
	var intersection = plane.intersects_ray(origin_ray, direction)
	
	if intersection != null:
		var target: Vector3 = intersection
		target.x = clamp(target.x, min_x, max_x)
		target.z = clamp(target.z, min_z, max_z)
		target.y = global_position.y
		global_position = target
