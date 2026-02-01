extends ComponentClass
class_name EnemyControlComponent

enum Type { WALKING, FLYING }

@export_category("Necessary Nodes")
@export var actor: Node2D

@export_category("Movement Paramters")
@export var EnemyType: Type
@export var speed: float = 150.0
@export var gravity: float = 2000.0
@export var jump_strength: float = 800.0

@onready var direction: float = 1.0

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	direction = 1 if _rng.randf() < 0.5 else -1

func stop() -> void:
	if not actor is CharacterBody2D: return
	actor.velocity.x = 0

func apply_gravity(delta: float) -> void:
	if actor.is_on_floor() and not actor is CharacterBody2D: return
	actor.velocity.y += gravity * delta

func apply_horizontal_movement() -> void:
	if actor is CharacterBody2D:
		actor.velocity.x = direction * speed

func jump_in_direction() -> void:
	if not actor is CharacterBody2D: return
	actor.velocity = Vector2(direction * speed, -jump_strength)
