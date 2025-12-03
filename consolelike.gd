extends Label

var mainbit = ""
var available = false
var words = []
@export var cooldown_max = 0.05
var cooldown_current = 0
var index = 0
@export var by_word = false
@export var next_text:Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") and visible:
		index = words.size()
		text = mainbit

func seperate_by_spaces(str):
	var words = []
	var word = ""
	for char in str:
		if char==" ":
			words.append(word)
			word = ""
		else:
			word+=char
	return words
	
func seperate_by_chars(str):
	var characters= []
	for char in str:
		characters.append(char)
	return characters
func _ready() -> void:
	mainbit = text
	text = ""
	if by_word:
		words = seperate_by_spaces(mainbit)
	else:
		words = seperate_by_chars(mainbit)
	

func _process(delta: float) -> void:
	if visible:
		if cooldown_current <= 0 and index<words.size():
			if by_word:
				text += words[index]+" "
			else:
				text+=words[index]
			index+=1
			cooldown_current = cooldown_max
		elif cooldown_current > 0:
			cooldown_current -= delta
		else:
			$prompt.position.y = size.y
			$prompt.visible = true
		
func Finnished():
	next_text.visible=true
	visible = false
	
			
