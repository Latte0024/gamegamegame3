extends TextureButton



@export var battleHandler:Node

@onready var anim:AnimationPlayer = $animation
@onready var health:TextureProgressBar = $health
@export var damageVal:int



func _on_focus_entered() -> void:
	anim.play("select")


func _on_focus_exited() -> void:
	anim.stop()


func damage(value:float, who:String):
	battleHandler.text.newline()
	if sign(value) == -1:
		if who == self.name:
			battleHandler.text.append_text(str(who," recovers ", value * (-1), " health!"))
		else:
			battleHandler.text.append_text(str(who," heals ",self.name, " for ", value * (-1), " health!"))
	else:
		if who == self.name:
			battleHandler.text.append_text(str(who," hurts themseleves for ",value, " damage!"))
		else:
			battleHandler.text.append_text(str(who," deals ",value, " damage to ", self.name, "!"))
	health.value -= value
	if health.value <= 0:
		battleHandler.text.newline()
		if who == self.name:
			battleHandler.text.append_text(str(self.name, " downed themselves!"))
		else:
			battleHandler.text.append_text(str(self.name, " was slain!"))
		self.queue_free()
