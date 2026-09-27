extends Area2D









func _ready():
	if Puzzleswitch.rock2gone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch2on", visible2on)
		Puzzleswitch.connect("Rockswitch2off", visible2off)




func visible2on():
	Puzzleswitch.rock2gone  = true
	visibility()


func visible2off():
	Puzzleswitch.rock2gone  = false
	visibility()

func visibility():
	if Puzzleswitch.rock2gone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rock2gone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rock2gone = true
		print("hidden")
