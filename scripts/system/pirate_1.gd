extends Area2D


func _ready():
	if Puzzleswitch.pirategone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Pirateswitch1on", visible1on)
		Puzzleswitch.connect("Pirateswitch1off", visible1off)




func visible1on():
	Puzzleswitch.pirategone  = true
	visibility()


func visible1off():
	Puzzleswitch.pirategone  = false
	visibility()

func visibility():
	if Puzzleswitch.pirategone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.pirategone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.pirategone = true


func _on_body_entered(body: Node2D) -> void:
	if $".".is_visible_in_tree():
		body.set_position($Marker2D.global_position)
		print("ghalo")
		Fade.fade.emit()
