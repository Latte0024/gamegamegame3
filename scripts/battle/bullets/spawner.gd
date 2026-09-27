extends CharacterBody2D


@export var physics : bool
@export var pos = Vector2 (0,0)
@export var blank = "res://scripts/battle/bullets/rigidbullet.tscn"





#	res://scripts/battle/bullets/rigidbullet.tscn
#	res://scripts/battle/bullets/markerbullet.tscn








func _ready() -> void:


	shoot()





func shoot():
	var bullet :PackedScene = load(blank)
	await get_tree().create_timer(.3).timeout
	var new_bullet = bullet.instantiate()

	new_bullet.position = position + pos
	get_parent().add_child.call_deferred(new_bullet)
