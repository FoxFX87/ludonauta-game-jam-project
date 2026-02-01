extends Node

enum Type { 
	WALK, STOMP, JUMP, ENEMYHIT, PLAYER_HIT, PLAYER_DROP, PLAYER_GAMEOVER,
	DOORSLAM, 
	}

@onready var walk_audio: Node = $WalkAudio
@onready var stomp_audio: Node = $StompAudio
@onready var audio_list: Node = $AudioList
@onready var jump_audio: Node = $JumpAudio
@onready var enemy_hit: Node = $EnemyHit
@onready var player_hit: Node = $PlayerHit
@onready var player_drop: Node = $PlayerDrop
@onready var player_game_over: Node = $PlayerGameOver
@onready var door_slam: Node = $DoorSlam

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

func play_audio(type: Type) -> void:
	var audio: AudioStreamPlayer
	match type:
		Type.WALK:
			audio = get_random_audio(walk_audio).duplicate()
		Type.STOMP:
			audio = get_random_audio(stomp_audio).duplicate()
		Type.JUMP:
			audio = get_random_audio(jump_audio).duplicate()
		Type.ENEMYHIT:
			audio = get_random_audio(enemy_hit).duplicate()
		Type.PLAYER_HIT:
			audio = get_random_audio(player_hit).duplicate()
		Type.PLAYER_DROP:
			audio = get_random_audio(player_drop).duplicate()
		Type.PLAYER_GAMEOVER:
			audio = get_random_audio(player_game_over).duplicate()
		Type.DOORSLAM:
			audio = get_random_audio(door_slam).duplicate()
		_:
			pass
	set_and_play_audio(audio)

func set_and_play_audio(sfx: AudioStreamPlayer) -> void:
	audio_list.add_child(sfx)
	sfx.finished.connect(sfx.queue_free)
	sfx.play()

func get_random_audio(parent_node: Node) -> AudioStreamPlayer:
	var index: int = _rng.randi() % parent_node.get_child_count()
	return parent_node.get_child(index)
