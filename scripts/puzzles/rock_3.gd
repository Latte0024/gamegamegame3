extends Area2D









func _ready():
	if Puzzleswitch.rock3gone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Rockswitch3on", visible3on)
		Puzzleswitch.connect("Rockswitch3off", visible3off)




func visible3on():
	Puzzleswitch.rock3gone  = true
	visibility()


func visible3off():
	Puzzleswitch.rock3gone  = false
	visibility()

func visibility():
	if Puzzleswitch.rock3gone  == false:
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
		Puzzleswitch.rock3gone = false

	else:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		Puzzleswitch.rock3gone = true
