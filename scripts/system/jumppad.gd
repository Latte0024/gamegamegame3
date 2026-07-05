extends Area2D

func _physics_process(delta: float) -> void:
	if self.has_overlapping_bodies() and Input.is_action_just_pressed("interact"):
		self.get_overlapping_bodies()[0].global_position = $Marker2D.global_position
