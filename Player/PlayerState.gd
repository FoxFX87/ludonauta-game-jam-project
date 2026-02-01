extends State
class_name PlayerState

const IDLE: StringName = "Idle"
const MOVE: StringName = "Move"
const AIR: StringName = "Air"
const DROP: StringName = "Drop"
const WALLJUMP: StringName = "WallJump"
const HARDLAND: StringName = "HardLand"

@export var actor: CharacterBody2D
@export var actor_sprite: Sprite2D
@export var platformer_component: Platformer2DComponent
@export var sprite_direction_node: Node2D
@export var sprite_origin_node: Node2D
@export var sprite_player: AnimationPlayer
@export var squash_component: SquashStretchComponent
@export var bounce_component: BounceableComponent
