extends Area2D
class_name OneTimeArea

func _ready() -> void:
	body_entered.connect(
		func _on_enter(_body: Node2D):
			trigger_event()
			queue_free()
	)

func trigger_event() -> void:
	pass
