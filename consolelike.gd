extends Label

var mainbit = ""
var available = false
var words = []
@export var cooldown_max = 0.05
var cooldown_current = 0
var index = 0

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
	
func _ready() -> void:
	mainbit = text
	text = ""
	words = seperate_by_spaces(mainbit)

func _process(delta: float) -> void:
	if cooldown_current <= 0 and index<words.size():
		text += words[index]+" "
		index+=1
		cooldown_current = cooldown_max
	elif cooldown_current > 0:
		cooldown_current -= delta
	else:
		$prompt.position.y = size.y
		$prompt.visible = true
			
