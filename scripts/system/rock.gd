extends Area2D









func _ready():
	if Puzzleswitch.rockgone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch1on", visible1on)
		Puzzleswitch.connect("Rockswitch1off", visible1off)




func visible1on():
	Puzzleswitch.rockgone  = true
	visibility()


func visible1off():
	Puzzleswitch.rockgone  = false
	visibility()

func visibility():
	if Puzzleswitch.rockgone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rockgone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rockgone = true
