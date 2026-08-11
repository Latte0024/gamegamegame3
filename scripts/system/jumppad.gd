extends Area2D

var markerpos 

func _physics_process(delta: float) -> void:
	markerpos = $Marker2D.global_position
	shade()

func shade():
	if self.has_overlapping_bodies() and Input.is_action_just_pressed("interact"):
		PhysicsStuff.markerposition = markerpos
		PhysicsStuff.following = true
		PhysicsStuff.FollowTrue.emit()
