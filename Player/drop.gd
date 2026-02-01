extends PlayerState

@export var drop_force: float = 3000
@export var hurt_area_collision: CollisionShape2D

func enter(_previous_state_path: String, _data := {}) -> void:
	hurt_area_collision.disabled = true
	platformer_component.stop()
	actor.velocity.y = drop_force
	AudioManager.play_audio(AudioManager.Type.PLAYER_DROP)
	sprite_player.play(AIR)

func physics_update(_delta: float) -> void:
	platformer_component.apply_gravity(_delta)
	
	if actor.is_on_floor():
		finished.emit(HARDLAND)
