extends Area2D


@export var rocknumber : int
@export var rockoffnumber : int


var delay : bool
var inside : bool
var on : bool = false


func _ready() -> void:
	if Puzzleswitch.rocknumber != rocknumber :
		$on.hide()

func _process(_delta: float) -> void:
	check()



func _on_area_entered(_area: Area2D):
	inside = true

func _on_area_exited(_area: Area2D):
	inside = false


func check():
	if inside == true and Input.is_action_just_pressed("interact") and on == false and delay == false :
		on = true
		Puzzleswitch.rocknumber = rocknumber
		texture()
		delaying()
		

	elif inside == true and Input.is_action_just_pressed("interact") and on == true and delay == false :
		on = false
		Puzzleswitch.rockoffnumber = rockoffnumber
		Puzzleswitch.rocknumber = 0
		texture()
		delaying()



func delaying():
	delay = true

	await get_tree().create_timer(1).timeout
	delay = false

func texture():
	if on == true:
		$on.show()
		$off.hide()
	if on == false:
		$on.hide()
		$off.show()
