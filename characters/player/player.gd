extends CharacterBody2D
class_name player

@export var _animated_sprite : AnimatedSprite2D
@export var speed = 400.0
@export var jump_velocity = -400
@export var moving : bool
@export var pos : Vector2
@export var oldpos : Vector2
@export var icephysics : bool
@export var inpirate : bool
@export var monsters : Array[enemyData]

var forcefollow : bool

var target 



func get_input():
	if forcefollow == true:
		return
	else:
		if  icephysics == false or icephysics == true and moving == false:
			var input_direction = Input.get_vector("left", "right", "up", "down")
			velocity = input_direction * speed





@warning_ignore("unused_parameter")

func _physics_process(delta):
	get_input()
	move_and_slide()
	shade()
	

	pos = global_position
	if pos - oldpos:
		moving = true
	else:
		moving = false
	oldpos = pos


	
func _process(_delta):	#animation
		if Input.is_action_pressed("sprint"):
			speed =  800.0
		else:
			speed = 400.0

		if moving == true and forcefollow == false:
			if Input.is_action_pressed("up"):
				_animated_sprite.play("walk up")
			elif Input.is_action_pressed("down",):
				_animated_sprite.play("walk down")
			elif Input.is_action_pressed("left",):
				_animated_sprite.play("walk left")
			elif Input.is_action_pressed("right",):
				_animated_sprite.play("walk right")
			else:
				_animated_sprite.stop()
		elif forcefollow == true:
			_animated_sprite.play("flying")
		else:
			_animated_sprite.stop()




func _ready():
	PhysicsStuff.connect("icephysicsoff", iceoff)
	PhysicsStuff.connect("icephysicson", iceon)

	iceon()
	iceoff()





func iceoff():
	icephysics = false
	ice()


func iceon():
	icephysics = true
	ice()
	
func ice():
	if moving == false:
		icephysics = false




func shade():
	target = PhysicsStuff.markerposition
	forcefollow = PhysicsStuff.following

	if PhysicsStuff.following == true:
		
		print(PhysicsStuff.markerposition)
		global_position = global_position.move_toward(target , 10)
		$CollisionShape2D.disabled = true


	else:
		return
	if pos == target:
		PhysicsStuff.following = false
		$CollisionShape2D.disabled = false
