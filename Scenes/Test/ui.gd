extends CanvasLayer

@onready var transition_player: AnimationPlayer = $TransitionPlayer

func _ready() -> void:
	Events.on_door_entered.connect(on_game_won)
	Events.on_lost.connect(on_player_lost)

func on_game_won() -> void:
	transition_player.play("FadeIn")

func restart_game() -> void:
	get_tree().reload_current_scene()

func on_player_lost() -> void:
	transition_player.play("GameOver")

func _on_game_over_button_pressed() -> void:
	Global.level = 0
	transition_player.play("FadeIn")
	pass # Replace with function body.
