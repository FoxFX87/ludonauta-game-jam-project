extends ComponentClass
class_name BounceableComponent

const TARGETGROUP: StringName = "Bounceable"

@export var actor: CharacterBody2D
@export var bounce_area: Area2D

func _physics_process(_delta: float) -> void:
	#bounce_area.monitoring = actor.velocity.y > 0.0
	pass

func can_bounce() -> bool:
	return bounce_area.has_overlapping_bodies()

func get_bounce_targets() -> Array[Node2D]:
	return bounce_area.get_overlapping_bodies()
