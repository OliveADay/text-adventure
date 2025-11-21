extends Label
signal finished

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		finished.emit()
