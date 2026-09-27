extends Node2D

## array of enemydata thats used for enemies in the encounter
@export var enemyPool:Array[enemyData]
## toggles whether encounter Node will chase player when inside fetchArea
@export var willFetch:bool = true

@export_group("Apearance")

## when true allows customization of overworld spirtes.
## properties in this category are effectively useless when this is false 
## [br][br]
## [b]Note:[/b] Forced sprites will scale to their native size if [param forcedSpriteWidth] or [param forcedSpriteHeight] is set to 0
@export var forceApperance:bool = false
@export var forcedSprite:Texture2D
@export var forcedSpriteWidth:int
@export var forcedSpriteHeight:int

@onready var sprite:TextureRect = $overworldSprite
@onready var fetchArea:Area2D = $fetchArea

func _ready() -> void:
	
	# If i dont have enemies im gonna kill myself
	if enemyPool.is_empty():
		queue_free()
	
	# If we met already im gonna kill myself
	if self.name in BattleGlobals.defeatedEncounters:
		queue_free()
	
	# Handles forced apperance params
	if forceApperance:
		sprite.texture = forcedSprite
		
		if (forcedSpriteHeight != 0) and (forcedSpriteWidth != 0):
			sprite.size.y = forcedSpriteHeight
			sprite.size.x = forcedSpriteWidth
			
		else:
			sprite.size.y = forcedSprite.get_height()
			sprite.size.x = forcedSprite.get_width()
		
	else:
		sprite.texture = enemyPool.pick_random().texture
	
	

func _physics_process(delta: float) -> void:
	if !fetchArea.get_overlapping_bodies().is_empty() and willFetch:
		global_position = global_position + global_position.direction_to(fetchArea.get_overlapping_bodies().front().global_position) * 200 * delta

func _onCollision(_body: Node2D) -> void:
	BattleGlobals.enemyPool.append_array(enemyPool)
	BattleGlobals.started.emit()
	BattleGlobals.defeatedEncounters.append(self.name)
	queue_free()
