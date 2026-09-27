extends Area2D

@onready var markerposition = $Marker2D.global_position
@export var damage : int
@export var followingP : float
@export var followingM : float
@export var time : int




func _process(delta: float) -> void:
	deleting()
	targeting()




func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	BattleGlobals.partyHealth[0] = BattleGlobals.partyHealth[0] + damage
	queue_free()


func targeting():


	if $range.has_overlapping_bodies():
		
		global_position = global_position.move_toward(BattleGlobals.partyLocation, followingP)


	else:
		global_position = global_position.move_toward( markerposition , followingM)



func deleting():
		await get_tree().create_timer(time).timeout
		print("timeout")
		queue_free()
