extends Node


signal icephysicsoff
signal icephysicson





func _on_area_exited(_area: Area2D):
	Icephysics.icephysicsoff.emit()



func _on_area_entered(_area: Area2D):
	Icephysics.icephysicson.emit()
