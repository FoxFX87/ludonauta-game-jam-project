extends CanvasLayer
class_name TutorialCanvas

func _ready() -> void:
	if Global.instructed:
		queue_free()
