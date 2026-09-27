extends Area2D

var inside : bool
var on : bool
var delay : bool
var moving : int

func _physics_process(delta):
	interaction()
	texture()

func _ready():
	$sprite/TileMapLayer.set_collision_enabled(false)
	$"sprite/JUMPPAD2 (not interactable)/CollisionShape2D".disabled = true
func interaction():
	if inside == true and on == false and moving == 0 and Input.is_action_just_pressed("interact"):
		moving = 2


		
		$sprite.rotation_degrees = -150
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -120
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -90
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -60
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -30
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = 0
		await get_tree().create_timer(0.5).timeout
		$sprite/TileMapLayer.set_collision_enabled(true)
		$"sprite/JUMPPAD2 (not interactable)/CollisionShape2D".disabled = false
		await get_tree().create_timer(0.5).timeout

		moving = 1
		on = true


	if inside == true and on == true and moving == 1 and Input.is_action_just_pressed("interact"):
		
		moving = 2
		$sprite/TileMapLayer.set_collision_enabled(false)
		$"sprite/JUMPPAD2 (not interactable)/CollisionShape2D".disabled = true
		$sprite.rotation_degrees = -30
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -60
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -90
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -120
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -150
		await get_tree().create_timer(0.5).timeout
		$sprite.rotation_degrees = -180
		await get_tree().create_timer(0.5).timeout

		
		moving = 0
		on = false

	else:
		return


func _on_area_entered(area: Area2D):
	inside = true
	

func _on_area_exited(area: Area2D):
	inside = false






func texture():
	if on == true:
		$on.show()
		$off.hide()
	if on == false:
		$on.hide()
		$off.show()
