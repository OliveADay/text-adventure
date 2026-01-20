extends Label

var mainbit = ""
var available = false
var words = []
@export var cooldown_max = 0.05
var cooldown_current = 0
var index = 0
@export var by_word = false
@export var next_text:Node
@export var next_prompt:Node
const SAVE_FILE_PATH = "user://save.cfg"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") and visible:
		index = words.size()
		var main_encode = encode(mainbit)
		text = main_encode

func seperate_by_spaces(string):
	var inst_words = []
	var word = ""
	for charac in string:
		if charac==" ":
			inst_words.append(word)
			word = ""
		else:
			word+=charac
	return inst_words
	
func seperate_by_chars(string):
	var characters= []
	for charac in string:
		characters.append(charac)
	return characters
	
func encode(string):
	var new_string = ""
	for charac in string:
		if charac != "@":
			new_string+=charac
	if load_name() != "":
		new_string = new_string.replace("[name]",load_name())
	return new_string
	
func _ready() -> void:
	if load_name() == "":
		mainbit = text
	else:
		mainbit = text.replace("[name]",load_name())
	text = ""
	if by_word:
		words = seperate_by_spaces(mainbit)
	else:
		words = seperate_by_chars(mainbit)
	

func _process(delta: float) -> void:
	if visible:
		if cooldown_current <= 0 and index<words.size():
			if words[index] == "@":
				index+=1
				cooldown_current = cooldown_max*2
			else:
				if by_word:
					text += words[index]+" "
				else:
					text+=words[index]
				index+=1
				cooldown_current = cooldown_max
		elif cooldown_current > 0:
			cooldown_current -= delta
		else:
			next_prompt.position.y = size.y
			next_prompt.visible = true
			
		
func Finnished():
	next_text.visible=true
	visible = false
	for child in get_children():
		child.visible = false
func load_name():
	var config = ConfigFile.new()
	var error = config.load(SAVE_FILE_PATH)
	if error != OK:
		return ""
	return config.get_value("main","name")
	
			
