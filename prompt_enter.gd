extends Label
signal activated
var checker =  0
const SAVE_FILE_PATH = "user://save.cfg"
@export var textedPrompt:TextEdit
@export var is_name = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") and visible:
		activated.emit()
		if is_name and textedPrompt != null:
			save_name(textedPrompt.text)
		print("entered_"+name)
		
func save_name(given_name):
	var config = ConfigFile.new()
	config.set_value("main","name",given_name)
	config.save(SAVE_FILE_PATH)
