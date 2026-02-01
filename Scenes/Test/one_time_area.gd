extends OneTimeArea

const TRACK_1 = preload("uid://cg8lpm1fepw7d")


func trigger_event() -> void:
	if not Global.instructed:
		Global.instructed = true
	if not MusicManager.music_player.playing:
		MusicManager.play_song.emit(TRACK_1,  true, false, 0.3)
