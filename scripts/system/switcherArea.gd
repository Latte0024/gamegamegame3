extends Area2D

@export var toScene:String = "res://maps/CH1/Forest.tscn"
@export var pos:Vector2 = Vector2(0,0)


func _on_body_entered(_body: Node2D) -> void:
	get_parent().get_parent().call_deferred("switch",get_parent(), toScene, pos)
