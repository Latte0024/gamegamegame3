extends Area2D


@export var selfnumber : int
@export var selfoffnumber : int

var delay : bool
var inside : bool
var on : bool = false


func _ready() -> void:
	if Puzzleswitch.number != selfnumber :
		$on.hide()

func _process(_delta: float) -> void:
	check()



func _on_area_entered(area: Area2D):
	inside = true

func _on_area_exited(area: Area2D):
	inside = false


func check():
	if inside == true and Input.is_action_just_pressed("interact") and on == false and delay == false :
		on = true
		Puzzleswitch.number = selfnumber
		texture()
		delaying()
		

	elif inside == true and Input.is_action_just_pressed("interact") and on == true and delay == false :
		on = false
		Puzzleswitch.offnumber = selfoffnumber
		Puzzleswitch.number = 0
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
