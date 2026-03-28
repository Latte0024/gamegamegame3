extends Area2D









func _ready():
	if Puzzleswitch.rockgone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch3on", visible3on)
		Puzzleswitch.connect("Rockswitch3off", visible3off)




func visible3on():
	Puzzleswitch.rockgone  = true
	visibility()


func visible3off():
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
