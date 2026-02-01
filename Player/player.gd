extends CharacterBody2D

@onready var platformer_2d: Platformer2DComponent = $Platformer2DComponent
@onready var sprite_direction: Node2D = $SpriteOrigin/SpriteDirection

func _physics_process(_delta: float) -> void:
	if velocity.y < 0:
		platformer_2d.enable_passthrough()
	elif velocity.y > 0:
		platformer_2d.disable_passthrough()
	move_and_slide()

func _on_hazard_area_body_entered(_body: Node2D) -> void:
	defeated()
	pass # Replace with function body.


func _on_hurt_area_2d_hurt(_damage: int) -> void:
	defeated()
	pass # Replace with function body.

func defeated() -> void:
	AudioManager.play_audio(AudioManager.Type.PLAYER_HIT)
	AudioManager.play_audio(AudioManager.Type.PLAYER_GAMEOVER)
	MusicManager.stop_music.emit()
	Events.on_lost.emit()
	queue_free()
	
