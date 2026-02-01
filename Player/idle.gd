extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	sprite_player.play(IDLE)
	platformer_component.stop()
	
	if _data.has("landed"):
		squash_component.squash_down()

func physics_update(_delta: float) -> void:
	if platformer_component.is_jumping():
		finished.emit(AIR, { jump = true })
	
	if platformer_component.is_moving():
		finished.emit(MOVE)
	elif not actor.is_on_floor():
		finished.emit(AIR)
	pass
