extends Resource
class_name skill

## name displayed in menu and when used
@export_placeholder("Very cool skill") var skillName:String

## describes the skill in menu
@export_placeholder("thid skill gets you mAD FUCKING BITCHES AND HUGE COCK") var skillDesc:String

## who the skill tagets
enum target {
		## user of spell only, skips target confirmation
	me,
	
	## any ally
	friend, 
	
	## all allies, skips target confirmation
	friends, 
	
	## any enemy
	foe, 
	
	## all enemies, skips target confirmation
	foes, 
	
	## anyone from the field, targeted side can be toggled with [kbd]LShift[/kbd] by default
	any, 
	
	## same as [param any] but the whole side is affected, skips target confirmation
	anys,
	 
	## everyone on field
	all
	}


## choose who the skill tagets
@export var targeting:target

## how much damage the skill does, before level scaling multipliers, negative values mean healing
## [br][br]
## [b]Note:[/b] because this value is before multipliers try to keep this value pretty low or vparam scaling] lower
@export_range(-999, 999) var effect:int


@export var cost:int

## how much the skill's effect should increase per character level
## [br][br]
## [code]target.damage(skill.effect * (1 + (skill.scaling * battleGlobals.partyLevel) )[/code]
## [br][br]
##[b]Note:[/b] If [param damage(value)] is called when [param value] is negative, the target will be healed instead of damaged
@export_range(0,1,0.05) var scaling:float
