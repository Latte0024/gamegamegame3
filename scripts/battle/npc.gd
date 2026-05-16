extends CharacterBody2D



func Initiate():
	Battlestarter.BattleStart.emit()




func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		Initiate()
