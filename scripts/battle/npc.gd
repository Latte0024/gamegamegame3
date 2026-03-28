extends CharacterBody2D
class_name EnemyNPC

@export var eHP : int = 100
@export var hurtbox : Area2D
@export var HPbar : ProgressBar
@export var enemyname : String = "Slime"
@export var eturnspeed = 10
@export var eattack = 20
@export var ecrit = 5
@export var edef = 10
@export var eevasion = 5



func Initiate():
	Battlestarter.BattleStart.emit()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		Initiate()
