extends Node2D
const SAVE_FILE_PATH = "user://save.cfg"

func _ready() -> void:
	pass
	#if load_name() != "":
	#	$textbit.visible = false
	#	$teleport.visible = true

func load_name():
	var config = ConfigFile.new()
	var error = config.load(SAVE_FILE_PATH)
	if error != OK:
		return ""
	return config.get_value("main","name")
