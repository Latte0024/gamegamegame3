extends Node

var following : bool
var markerposition 


signal FollowTrue
signal FollowFalse






signal icephysicsoff
signal icephysicson





func _on_area_exited(_area: Area2D):
	PhysicsStuff.icephysicsoff.emit()



func _on_area_entered(_area: Area2D):
	PhysicsStuff.icephysicson.emit()
