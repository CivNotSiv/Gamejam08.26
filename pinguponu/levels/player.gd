extends Node3D

@onready var cam: Camera3D = $"../Player_data/Anchor/Camera3D"
@onready var playable_area: MeshInstance3D = $"../Playable_area"

func _ready() -> void:
	$Area3D.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var ray_origin: Vector3 = cam.project_ray_origin(mouse_pos)
	var ray_direction: Vector3 = cam.project_ray_normal(mouse_pos)

	var plane := Plane(playable_area.global_transform.basis.y.normalized(), playable_area.global_position)
	var intersection: Variant = plane.intersects_ray(ray_origin, ray_direction)

	if intersection != null:
		var target: Vector3 = intersection
		var plane_mesh := playable_area.mesh as PlaneMesh
		var size: Vector2 = plane_mesh.size
		var half_size := size / 2.0
		var local_target: Vector3 = playable_area.to_local(target)

		local_target.x = clamp(
			local_target.x,
			-half_size.x,
			half_size.x
		)

		local_target.z = clamp(
			local_target.z,
			-half_size.y,
			half_size.y
		)

		target = playable_area.to_global(local_target)
		global_position = target
		
		var cursor_pos: Vector2 = cam.unproject_position(global_position)
		if mouse_pos.distance_to(cursor_pos) > 2.0:
			get_viewport().warp_mouse(cursor_pos)
		
		look_at(Vector3((size.x / 2), 1, 0))

func _on_body_entered(body: Node3D) -> void:
	var body_rigid := body as RigidBody3D
	if body_rigid:
		body_rigid.linear_velocity = Vector3(-40, 0, 0)
		print("collision!!")
