extends Area2D

var inside : bool
var on : bool
var delay : bool

func _ready():
	$temprock1/TileMapLayer.set_collision_enabled(false)

func _physics_process(delta):
	interaction()
	texture()


func interaction():
	if inside == true and on == false and delay == false and Input.is_action_just_pressed("interact"):
		$temprock1/TileMapLayer.hide()
		$temprock1/TileMapLayer.set_collision_enabled(false)
		on = true
		$Timer.start()

	if inside == true and on == true and delay == true and Input.is_action_just_pressed("interact"):
		$temprock1/TileMapLayer.show()
		$temprock1/TileMapLayer.set_collision_enabled(true)
		on = false
		$Timer.start()
	else:
		return


func _on_area_entered(area: Area2D):
	inside = true
	

func _on_area_exited(area: Area2D):
	inside = false


func _on_timer_timeout():
	delay = true
	if delay == true and on == false:
		$Timer.start()
		delay = false



func texture():
	if on == true:
		$on.show()
		$off.hide()
	if on == false:
		$on.hide()
		$off.show()
