extends CanvasLayer

@onready var shockwave_rect: ColorRect = $ShockwaveRect
@onready var shader_material: ShaderMaterial = shockwave_rect.material
@onready var shockwave_player: AnimationPlayer = $ShockwavePlayer
@onready var camera : Camera2D = get_viewport().get_camera_2d()

func _ready() -> void:
	Events.create_shockwave.connect(on_shockwave)

func on_shockwave(location: Vector2) -> void:
	var screen_pos: Vector2 = camera.get_screen_transform().basis_xform(location)
	var viewport_size: Vector2 = camera.get_viewport_rect().size
	shader_material.set_shader_parameter("size", viewport_size)
	shader_material.set_shader_parameter("global_position", screen_pos)
	shockwave_player.play("Shock")
