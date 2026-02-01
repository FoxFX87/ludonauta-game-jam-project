extends Node

@export var enemies: Node2D
@export var camera: Camera2D
@export var generator: RandomWalker

func _ready() -> void:
	Events.on_game_won.connect(on_game_won)

func on_game_won() -> void:
	
	for enemy: Node2D in enemies.get_children():
		queue_free()
	camera.limit_smoothed = true
	camera.limit_top = -int((generator.height) * camera.get_viewport_rect().size.y)
	camera.limit_bottom = -int((generator.height - 1) * camera.get_viewport_rect().size.y)
