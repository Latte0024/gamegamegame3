extends Control 

@onready var heartbeat = $heartbeat/TextureRect/AnimatedSprite2D

signal closed
signal opened




func _ready():
	Battlestarter.connect("BattleStart", Initiate)
	displaytext()
@warning_ignore("unused_parameter")

func displaytext():
	$everything.hide()
	$"Textbox for text".show()
	$"Textbox for text/Button".text = "Battle initiates!"



func Initiate():
	$"Textbox for text/Button".grab_focus()
	opened.emit()

func _on_opened():

	visible = true
	get_tree().paused = true
	

func _on_closed():
	visible = false
	get_tree().paused = false



	
func _process(_delta):
	heartbeat.play("heartbeat")



func _on_button_pressed():
	pass


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed():
	$"Textbox for text".show()
	closed.emit()



func _on_text_button_pressed():
	$"Textbox for text".hide()
	$everything.show()
	$everything/choice/choices/Attack.grab_focus()
