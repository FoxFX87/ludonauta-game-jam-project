extends CharacterBody2D

@onready var enemy_control_component: EnemyControlComponent = $EnemyControlComponent
@onready var ai_wall_floor_component: AIWallFloorComponent = $AIWallFloorComponent
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D

func _physics_process(delta: float) -> void:
	enemy_control_component.apply_gravity(delta)
	enemy_control_component.apply_horizontal_movement()
	ai_wall_floor_component.update(delta)
	sprite.flip_h = velocity.x > 0
	move_and_slide()


func _on_ai_wall_floor_component_switch_left() -> void:
	enemy_control_component.direction = -1
	pass # Replace with function body.


func _on_ai_wall_floor_component_switch_right() -> void:
	enemy_control_component.direction = 1
	pass # Replace with function body.


func _on_hurt_area_2d_hurt(_damage: int) -> void:
	AudioManager.play_audio(AudioManager.Type.ENEMYHIT)
	queue_free()
	pass # Replace with function body.


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	visible_on_screen_enabler_2d.queue_free()
	pass # Replace with function body.
