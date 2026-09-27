extends Area2D









func _ready():
	if Puzzleswitch.rock1gone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch1on", visible1on)
		Puzzleswitch.connect("Rockswitch1off", visible1off)




func visible1on():
	Puzzleswitch.rock1gone  = true
	visibility()


func visible1off():
	Puzzleswitch.rock1gone  = false
	visibility()

func visibility():
	if Puzzleswitch.rock1gone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rock1gone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rock1gone = true
