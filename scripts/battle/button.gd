extends Button

@export var partyIndex:int
@export var skillIndex:int

@export var battleHandler:Node
@onready var skillName = $"../../summary/name"
@onready var skillDesc = $"../../summary/desc"
func _ready() -> void:
	text = BattleGlobals.party[partyIndex].skills[skillIndex].skillName

func _on_pressed() -> void:
	battleHandler._target_select(BattleGlobals.party[partyIndex].skills[skillIndex].targeting, BattleGlobals.party[partyIndex].skills[skillIndex].effect, BattleGlobals.party[partyIndex].skills[skillIndex].scaling, BattleGlobals.party[partyIndex].skills[skillIndex].cost)
	battleHandler.skillmenu.visible = false
	battleHandler.text.visible = true


func _on_focus() -> void:
	skillName.text = BattleGlobals.party[partyIndex].skills[skillIndex].skillName
	skillDesc.text = BattleGlobals.party[partyIndex].skills[skillIndex].skillDesc
