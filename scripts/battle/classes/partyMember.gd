extends Resource
class_name partyMember

@export_placeholder("Raul") var name : String
@export var texture : Texture2D
@export var maxHealth : int = 100
@export var maxEnergy : int = 100
@export var skills : Array[skill]
@export var attack : int

## how much the basic attack's damage should increase per character level
## [br][br]
## [code]target.damage(user.attack * (1 + (user.atkScaling * battleGlobals.partyLevel) )[/code]
## [br][br]
##[b]Note:[/b] If [param damage(value)] is called when [param value] is negative, the target will be healed instead of damaged
@export_range(0,1,0.05) var atkScaling:float
