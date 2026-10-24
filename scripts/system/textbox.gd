extends Control


var dialogue : String 
@onready var textbox = $box/HBoxContainer/HBoxContainer/text

var textspeed = 0.001
var alltextvisible : bool
var visible_characters : float
signal interacted


var canend : bool
var alltext
var currenttext

func _process(delta: float) -> void:
	interact()
	



func _ready():
	alltextvisible = false
	currenttext = 0
	$".".visible = false

	Dialogue.talking.connect(talking)






func talking():

	if Dialogue.indialogue == true:
		textbox.visible_characters = 0
		
		dialogue = Dialogue.currenttext[currenttext]
		textbox.text = dialogue
		$".".visible = true
		typewriter()

		if currenttext == Dialogue.currenttext.size() -1:
			currenttext = -1



func typewriter():
	while textbox.visible_characters != -1:

		textbox.visible_ratio += textspeed
		alltextvisible = false

		await get_tree().process_frame
		alltextvisible = true


func interact():
	if Input.is_action_just_pressed("interact") and $".".visible == true :
		disappear()
		end()
		if alltextvisible == true and canend == false:
			currenttext = currenttext + 1
		print(currenttext)


		if alltextvisible == true and canend == false:
			talking()

func disappear():

	
	if textbox.visible_characters == -1 and currenttext == -1:
		canend = true
		print("quetite")
		
		

		
		
	elif textbox.visible_characters != -1 and alltextvisible == false:
		
		textbox.visible_characters = -1
		alltextvisible == true


func end():
	if canend == true:
		Dialogue.indialogue = false
		$".".visible = false
		textbox.visible_characters = 0
		currenttext = -1
		canend = false
