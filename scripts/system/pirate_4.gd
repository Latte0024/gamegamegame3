extends Area2D


func _ready():
	if Puzzleswitch.pirategone  == true:
		queue_free()
	else:
		Puzzleswitch.connect("Pirateswitch4on", visible4on)
		Puzzleswitch.connect("Pirateswitch4off", visible4off)




func visible4on():
	Puzzleswitch.pirategone  = true
	visibility()


func visible4off():
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
