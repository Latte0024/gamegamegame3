extends CharacterBody2D


func _ready():
	Dialogue.currenttext = [
	"aaaaaaaaaaaaa",
	"első szöveg aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	" MÁSODIK SZÖVEG",
	"lallalalallalaal",]
	
#var partyEnergy:Array[int] = [100,15,50]

func _on_area_2d_area_entered(area: Area2D) -> void:

	Dialogue.indialogue = true
	Dialogue.talking.emit()


	
