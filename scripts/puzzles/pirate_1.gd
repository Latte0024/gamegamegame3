extends Area2D


@export var selfnumber : int
@export var selfoffnumber : int
@export var delete : bool

func _process(_delta: float) -> void:
	visibility()
	deleting()



func deleting():
		if delete == true and $".".visible == false:
			queue_free()
		

func visibility():
	if Puzzleswitch.number == selfnumber:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)
		

		
	elif Puzzleswitch.offnumber == selfoffnumber :
		$".".show()
		$TileMapLayer.set_collision_enabled(true)




func _on_body_entered(body: Node2D) -> void:
	if $".".is_visible_in_tree():
		body.set_position($Marker2D.global_position)
		Fade.fade.emit()
