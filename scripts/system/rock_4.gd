extends Area2D









func _ready():
	if Puzzleswitch.rock4gone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch4on", visible4on)
		Puzzleswitch.connect("Rockswitch4off", visible4off)




func visible4on():
	Puzzleswitch.rock4gone  = true
	visibility()


func visible4off():
	Puzzleswitch.rock4gone  = false
	visibility()

func visibility():
	if Puzzleswitch.rock4gone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rock4gone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rock4gone = true
