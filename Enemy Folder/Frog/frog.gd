extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $SpriteOrigin/Sprite
@onready var ai_wall_floor_component: AIWallFloorComponent = $AIWallFloorComponent
@onready var enemy_control_component: EnemyControlComponent = $EnemyControlComponent
@onready var squash_stretch_component: SquashStretchComponent = $SquashStretchComponent
@onready var jump_timer: Timer = $JumpTimer
@onready var hop_audio: AudioStreamPlayer2D = $HopAudio
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D

func _ready() -> void:
	sprite.flip_h = enemy_control_component.direction > 0

func _physics_process(delta: float) -> void:
	enemy_control_component.apply_gravity(delta)
	ai_wall_floor_component.update(delta)
	if not is_zero_approx(velocity.x):
		sprite.flip_h = velocity.x > 0
	move_and_slide()
	
	if is_on_floor():
		sprite.play("Idle")
		enemy_control_component.stop()
		if jump_timer.is_stopped():
			jump_timer.start()
	else:
		sprite.play("Air")

func _on_jump_timer_timeout() -> void:
	squash_stretch_component.squash_up()
	hop_audio.play()
	enemy_control_component.jump_in_direction()
	pass # Replace with function body.


func _on_hurt_area_2d_hurt(_damage: int) -> void:
	queue_free()
	pass # Replace with function body.


func _on_ai_wall_floor_component_switch_left() -> void:
	velocity.x *= -1
	enemy_control_component.direction = sign(velocity.x)
	pass # Replace with function body.


func _on_ai_wall_floor_component_switch_right() -> void:
	velocity.x *= -1
	enemy_control_component.direction = sign(velocity.x)


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	visible_on_screen_enabler_2d.queue_free()
	pass # Replace with function body.
