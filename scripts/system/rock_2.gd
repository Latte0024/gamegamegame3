extends Area2D









func _ready():
	if Puzzleswitch.rockgone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch2on", visible2on)
		Puzzleswitch.connect("Rockswitch2off", visible2off)




func visible2on():
	Puzzleswitch.rockgone  = true
	visibility()


func visible2off():
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
