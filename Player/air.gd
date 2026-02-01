extends PlayerState

@export var hurt_area_collision: CollisionShape2D

func enter(_previous_state_path: String, _data := {}) -> void:
	sprite_player.play(AIR)
	
	if _data.has("jump"):
		squash_component.squash_up()
		platformer_component.jump()

func exit() -> void:
	hurt_area_collision.disabled = false

func physics_update(_delta: float) -> void:
	platformer_component.apply_gravity(_delta)
	platformer_component.apply_horizontal_movement()
	platformer_component.cancel_jump()
	
	hurt_area_collision.disabled = platformer_component.is_falling()
	
	if bounce_component.can_bounce() and platformer_component.is_falling():
		platformer_component.jump()
		squash_component.squash_up()
		
		for body: Node2D in bounce_component.get_bounce_targets():
			if body.is_in_group("Enemy"):
				AudioManager.play_audio(AudioManager.Type.ENEMYHIT)
				body.queue_free()
	
	if platformer_component.is_wall_jumping():
		finished.emit(WALLJUMP)
	
	if platformer_component.drop():
		finished.emit(DROP)
	
	if platformer_component.is_moving():
		actor_sprite.flip_h = platformer_component.direction.x < 0
		#sprite_direction_node.scale.x = sign(platformer_component.direction.x)
	
	if actor.is_on_floor():
		if platformer_component.is_moving():
			finished.emit(MOVE, {landed = true})
		else:
			finished.emit(IDLE, {landed = true})
