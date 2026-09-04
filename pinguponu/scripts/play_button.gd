extends Area3D

signal menu_pressed(action: String)
@export var action_name: String = "play"

@onready var mesh_instance: MeshInstance3D = $"play_button_model/Game Button"
var hover_material: StandardMaterial3D

func _ready() -> void:
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	var original_material = mesh_instance.get_active_material(0)
	hover_material = original_material.duplicate()
	hover_material.emission_enabled = true
	hover_material.emission = Color(1, 1, 1)
	hover_material.emission_energy_multiplier = 0.0

func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("menu_pressed", action_name)

func _on_mouse_entered():
	mesh_instance.set_surface_override_material(0, hover_material)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector3(1.1, 1.1, 1.1), 0.10)
	tween.tween_property(hover_material, "emission_energy_multiplier", 2.0, 0.15)

func _on_mouse_exited():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector3(1, 1, 1), 0.15)
	tween.finished.connect(func(): mesh_instance.set_surface_override_material(0, null))
