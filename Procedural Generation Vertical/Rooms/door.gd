extends Area2D
class_name EndDoor

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: CharacterBody2D) -> void:
	Global.level += 1
	body.queue_free()
	Events.on_door_entered.emit()
