extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	sprite_player.play(MOVE)
	
	if _data.has("landed"):
		squash_component.squash_down()

func physics_update(_delta: float) -> void:
	if not actor.is_on_floor():
		finished.emit(AIR)
	
	if platformer_component.is_jumping():
		finished.emit(AIR, { jump = true })
	
	if platformer_component.is_moving():
		actor_sprite.flip_h = platformer_component.direction.x < 0
		#sprite_direction_node.scale.x = sign(platformer_component.direction.x)
		platformer_component.apply_horizontal_movement()
	else:
		finished.emit(IDLE)
