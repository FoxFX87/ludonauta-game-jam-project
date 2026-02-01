extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	sprite_player.play(AIR)
	
	platformer_component.jump_wall()
	squash_component.squash_up()
	actor_sprite.flip_h = platformer_component.velocity_on_jump.x < 0
	AudioManager.play_audio(AudioManager.Type.JUMP)
	

func physics_update(_delta: float) -> void:
	platformer_component.apply_gravity(_delta)
	#platformer_component.apply_horizontal_movement()
	
	if bounce_component.can_bounce() and platformer_component.is_falling():
		finished.emit(AIR, { jump = true })
	
	if platformer_component.drop():
		finished.emit(DROP)
	
	if platformer_component.is_wall_jumping():
		platformer_component.jump_wall()
		squash_component.squash_up()
		actor_sprite.flip_h = platformer_component.velocity_on_jump.x < 0
		AudioManager.play_audio(AudioManager.Type.JUMP)
	
	if actor.is_on_floor():
		if platformer_component.is_moving():
			finished.emit(MOVE, {landed = true})
		else:
			finished.emit(IDLE, {landed = true})
