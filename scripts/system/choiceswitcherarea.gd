extends Area2D

@export var toScene:String = "res://maps/CH1/Forest.tscn"
@export var pos:Vector2 = Vector2(0,0)

func _physics_process(delta):
	teleporting()

func teleporting():
	if self.has_overlapping_bodies() and Input.is_action_just_pressed("interact"):
		print("lalala")
		get_parent().get_parent().call_deferred("switch",get_parent(), toScene, pos)


#func _on_body_entered(_body: Node2D) -> void:
