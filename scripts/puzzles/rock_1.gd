extends Area2D


@export var rocknumber : int 
@export var rockoffnumber : int 
@export var delete : bool 





func _process(_delta: float) -> void:
	visibility()
	deleting()



func deleting():
		if delete == true and $".".visible == false:
			queue_free()
		



func visibility():
	if Puzzleswitch.rocknumber == rocknumber:
		$".".hide()
		$TileMapLayer.set_collision_enabled(false)


		
	elif Puzzleswitch.rockoffnumber == rockoffnumber :
		$".".show()
		$TileMapLayer.set_collision_enabled(true)
