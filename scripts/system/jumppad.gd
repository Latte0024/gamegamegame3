extends Area2D




func _on_body_entered(body: Node2D):
	if Input.is_action_pressed("interact"):
		body.set_position($Marker2D.global_position)
