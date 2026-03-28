extends CharacterBody2D
class_name player

@export var _animated_sprite : AnimatedSprite2D
@export var speed = 400.0
@export var moving : bool
@export var pos : Vector2
@export var oldpos : Vector2
@export var icephysics : bool
@export var inpirate : bool




func get_input():
	if icephysics == false or icephysics == true and moving == false or inpirate == false:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed



@warning_ignore("unused_parameter")

func _physics_process(delta):
	get_input()
	move_and_slide()

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
		if Input.is_action_pressed("up") and icephysics == false or Input.is_action_pressed("up") and icephysics == true and moving == false:
			_animated_sprite.play("walk up")
		elif Input.is_action_pressed("down",) and icephysics == false or Input.is_action_pressed("down",) and icephysics == true and moving == false:
			_animated_sprite.play("walk down")
		elif Input.is_action_pressed("left",) and icephysics == false or Input.is_action_pressed("left",) and icephysics == true and moving == false:
			_animated_sprite.play("walk left")
		elif Input.is_action_pressed("right",) and icephysics == false or Input.is_action_pressed("right",) and icephysics == true and moving == false:
			_animated_sprite.play("walk right")
		else:
			_animated_sprite.stop()
	



func _ready():
	Icephysics.connect("icephysicsoff", iceoff)
	Icephysics.connect("icephysicson", iceon)
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
