extends Area3D


@onready var title_mesh: MeshInstance3D = $"title_model/Text"

func _ready():
	apply_gradient_emission()
	

func apply_gradient_emission():
	var material = title_mesh.get_active_material(0).duplicate()
	
	var gradient = Gradient.new()
	gradient.set_color(0, Color(0.6, 0.6, 0.6))
	gradient.set_color(1, Color(0.95, 0.95, 0.95))
	
	var gradient_texture = GradientTexture2D.new()
	gradient_texture.gradient = gradient
	gradient_texture.width = 256
	gradient_texture.height = 256
	gradient_texture.fill = GradientTexture2D.FILL_LINEAR
	gradient_texture.fill_from = Vector2(0, 0)
	gradient_texture.fill_to = Vector2(0, 1)

	material.emission_enabled = true
	material.emission_texture = gradient_texture
	material.emission_energy_multiplier = 1.5
	
	title_mesh.set_surface_override_material(0, material)	
