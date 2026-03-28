extends Area2D









func _ready():
	if Puzzleswitch.rockgone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch4on", visible4on)
		Puzzleswitch.connect("Rockswitch4off", visible4off)




func visible4on():
	Puzzleswitch.rockgone  = true
	visibility()


func visible4off():
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
