extends Area2D

var inside : bool
var on : bool
var delay : bool

func _physics_process(delta):
	interaction()
	texture()

func interaction():
	if inside == true and on == false and delay == false and Input.is_action_just_pressed("interact"):
		Puzzleswitch.Pirateswitch4on.emit()
		on = true
		$Timer.start()



	if inside == true and on == true and delay == true and Input.is_action_just_pressed("interact"):
		Puzzleswitch.Pirateswitch4off.emit()
		on = false


func _on_area_entered(area: Area2D):
	inside = true
	

func _on_area_exited(area: Area2D):
	inside = false


func _on_timer_timeout():
	delay = true
	if delay == true and on == false:
		$Timer.start()
		delay = false


func texture():
	if on == true:
		$on.show()
		$off.hide()
	if on == false:
		$on.hide()
		$off.show()
