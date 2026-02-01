extends ComponentClass
class_name SquashStretchComponent

@export var actor: Node2D
@export_range(0.1, 0.9, 0.1) var squash_up_width: float = 0.3
@export var squash_up_duration: float = 0.2
@export_range(1.1, 1.9, 0.1) var squash_down_width: float = 1.7
@export var squash_down_duration: float = 0.3

var tween: Tween

func squash_up() -> void:
	_squash(squash_up_width, squash_up_duration)

func squash_down() -> void:
	_squash(squash_down_width, squash_down_duration)

func hard_squash_down() -> void:
	_squash(1.9, 0.6)

func _squash(target_width: float, target_duration: float) -> void:
	tween = create_tween()
	actor.scale = Vector2(target_width, 2.0 - target_width)
	tween.tween_property(
		actor, "scale", Vector2.ONE, target_duration
	).set_trans(Tween.TRANS_SINE)
	
