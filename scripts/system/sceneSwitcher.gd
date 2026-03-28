extends SubViewport


func switch(destroy:Node, create:String, pos:Vector2):
	Fade.fade.emit()
	var bigscene:PackedScene = load(create)
	
	var switched = bigscene.instantiate()
	
	add_child(switched)
	
	remove_child(destroy)
	
	switched.get_child(-1).global_position = pos
