extends OneTimeArea

func trigger_event() -> void:
	Events.on_game_won.emit()
