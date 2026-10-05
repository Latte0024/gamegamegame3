extends CharacterBody2D


@export var physics : bool
@export var pos = Vector2 (0,0)
@export var blank = "res://scripts/battle/bullets/rigidbullet.tscn"
@export var repeat : int 
@export var delay : float
@export var amount : int
@onready var bvisible : bool
var visibility : bool
@export var randombool : bool
@export var randompos = Vector2 (0,0)
var a : int
var b : int


#	res://scripts/battle/bullets/rigidbullet.tscn
#	res://scripts/battle/bullets/markerbullet.tscn


#func _process(delta: float) -> void:

func _ready() -> void:
	shoot()

	print(is_visible_in_tree())



func shoot():
	while a != amount and is_visible_in_tree() == true:
		var bullet :PackedScene = load(blank)
		await get_tree().create_timer(delay).timeout
		var new_bullet = bullet.instantiate()

		new_bullet.position = position + pos
		get_parent().add_child.call_deferred(new_bullet)
		a = a + 1 
		print("amount ", a)
		print("repeat ", b)
		print(is_visible_in_tree())
	if a == amount and b != repeat:
		a = 0
		b = b + 1
		shoot()
	else:
		return
		




func _on_draw() -> void:
	a = 0
	b = 0
	amount = amount
	repeat = repeat
	shoot()
