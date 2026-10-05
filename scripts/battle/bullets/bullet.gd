extends RigidBody2D


@export var damage : int
@export var speed : float
@export var rotation1 : float
@export var velocity = Vector2(0, 0)
@export var bounce : bool
@export var time : int

@export var random : bool



# a, Vy > 0 -> down
# b, Vy < 0 -> up
# c, Vx > 0 -> right
# d, Vx < 0 -> left 

func _ready():
	PhysicsServer2D.set_active(true)

	if random == true:
		velocity = Vector2( velocity.x * (randi_range(-5, 5)), velocity.y * (randi_range(1, 10)))

	#	print([0 + (randi() % 50) , 0 + (randi() % 50)])




func _physics_process(delta: float) -> void:

	deleting()
	if bounce == false: 
		add_constant_central_force(velocity * speed)


	elif bounce == true:
		var collision_info = move_and_collide(velocity * speed)
		
		if collision_info:
			velocity = velocity.bounce(collision_info.get_normal())




func deleting():
		await get_tree().create_timer(time).timeout


		queue_free()


func _on_bullet_area_entered(area: Area2D) -> void:

	print("area entered")
	BattleGlobals.partyHealth[0] = BattleGlobals.partyHealth[0] - damage
	print("bullet " , BattleGlobals.partyHealth[0])
	queue_free()
