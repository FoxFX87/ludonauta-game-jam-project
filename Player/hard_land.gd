extends PlayerState

@export var duration: float = 0.3
@export var shockwave_vfx: GPUParticles2D
@export var hit_area_collision: CollisionShape2D
@export var hurt_area_collision: CollisionShape2D

@onready var timer: Timer = $Timer
@onready var stomp: AudioStreamPlayer = $Stomp

func enter(_previous_state_path: String, _data := {}) -> void:
	stomp.play()
	sprite_player.play(IDLE)
	platformer_component.stop()
	squash_component.hard_squash_down()
	timer.start(duration)
	call_deferred("_enable_land_effects")

func exit() -> void:
	hurt_area_collision.disabled = false

func _enable_land_effects():
	hit_area_collision.disabled = false
	shockwave_vfx.emitting = true

func _on_timer_timeout() -> void:
	hit_area_collision.disabled = true
	finished.emit(IDLE)
	pass # Replace with function body.
