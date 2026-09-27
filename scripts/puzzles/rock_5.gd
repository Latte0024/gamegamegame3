extends Area2D









func _ready():
	if Puzzleswitch.rock5gone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch5on", visible5on)
		Puzzleswitch.connect("Rockswitch5off", visible5off)




func visible5on():
	Puzzleswitch.rock5gone  = true
	visibility()


func visible5off():
	Puzzleswitch.rock5gone  = false
	visibility()

func visibility():
	if Puzzleswitch.rock5gone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rock5gone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rock5gone = true
