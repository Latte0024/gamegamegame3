extends VBoxContainer

@export var battleHandler:Node

@export var portrait:Texture2D
@export var health:int
@export var energy:int


@onready var healthbar = $health/bar
@onready var healthtext = $health/text

@onready var energybar = $energy/bar
@onready var energytext = $energy/text


@onready var anim:AnimationPlayer = $AnimationPlayer

var ownIndex:int

func _ready() -> void:
	healthbar.value = health
	healthtext.text = str(health)
	
	energybar.value = energy
	energytext.text = str(energy)
	
	$portrait.texture = portrait
	
	


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
	updateStats("health",value)
	if healthbar.value <= 0:
		battleHandler.text.newline()
		if who == self.name:
			battleHandler.text.append_text(str(self.name, " downed themselves!"))
		else:
			battleHandler.text.append_text(str(self.name, " was slain!"))
		self.queue_free()


func updateStats(stat:String,value):
	match stat:
		"health":
			health -= value
			BattleGlobals.partyHealth.set(ownIndex,health)
			healthbar.value = health
			healthtext.text = str(health)
		"energy":
			energy -= value
			BattleGlobals.partyEnergy.set(ownIndex,energy)
			energybar.value = energy
			energytext.text = str(energy)
