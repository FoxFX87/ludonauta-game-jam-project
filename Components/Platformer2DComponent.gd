extends ComponentClass
class_name Platformer2DComponent

@export_category("Necessary Nodes")
@export var actor: CharacterBody2D

@export_category("Movement Paramters")
@export var speed: float = 500.0
@export var gravity: float = 2000.0
@export var jump_strength: float = 800.0

@export_category("Inupts")
@export var move_left_action: StringName = "move_left"
@export var move_right_action: StringName = "move_right"
@export var jump_action: StringName = "jump"
@export var drop_down_action: StringName = "drop_down"

@export_category("Pass Through")
@export_flags_2d_physics var pass_through_layer: int = 2

@export_category("Wall Jumping")
@export var wall_check: RayCast2D

var direction: Vector2 = Vector2.ZERO:
	set(value):
		direction = value
		
		if not is_zero_approx(direction.x):
			wall_check.scale.x = sign(direction.x)
var velocity_on_jump: Vector2 = Vector2.ZERO

@onready var _layer_number = (log(pass_through_layer) / log(2)) + 1

func apply_gravity(delta: float) -> void:
	if actor.is_on_floor(): return
	actor.velocity.y += gravity * delta

func apply_horizontal_movement() -> void:
	direction.x = Input.get_axis(move_left_action, move_right_action)
	actor.velocity.x = direction.x * speed

func drop() -> bool:
	return Input.is_action_just_pressed(drop_down_action) and not actor.is_on_floor()

func is_jumping() -> bool:
	return actor.is_on_floor() and Input.is_action_just_pressed(jump_action)

func is_falling() -> bool:
	return actor.velocity.y > 0.0

func is_rising() -> bool:
	return actor.velocity.y < 0.0

func is_wall_jumping() -> bool:
	return Input.is_action_pressed(jump_action) and actor.is_on_wall()
	#return actor.is_on_wall() and Input.is_action_just_pressed(jump_action) and wall_check.is_colliding()

func jump_wall() -> void:
	var normal: Vector2 = actor.get_last_slide_collision().get_normal()
	velocity_on_jump = -normal * speed
	
	actor.velocity = velocity_on_jump.bounce(normal)
	actor.velocity.y = -jump_strength
	velocity_on_jump = actor.velocity

func stop() -> void:
	actor.velocity.x = 0

func is_moving() -> bool:
	return not is_zero_approx(Input.get_axis(move_left_action, move_right_action))

func jump() -> void:
	velocity_on_jump = actor.velocity
	actor.velocity.y = -jump_strength
	AudioManager.play_audio(AudioManager.Type.JUMP)

func cancel_jump() -> void:
	if not actor.is_on_floor() and actor.velocity.y < 0.0 and Input.is_action_just_released(jump_action):
		actor.velocity.y *= 0.5

func enable_passthrough() -> void:
	actor.set_collision_mask_value(_layer_number, false)

func disable_passthrough() -> void:
	actor.set_collision_mask_value(_layer_number, true)
