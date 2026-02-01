class_name OnScreenStart extends VisibleOnScreenEnabler2D

func _ready() -> void:
	screen_exited.connect(queue_free)
