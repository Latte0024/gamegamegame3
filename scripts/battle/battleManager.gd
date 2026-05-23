extends Control


@onready var text = $ui/status/margin/battleLog
@onready var skillmenu = $ui/status/margin/skills

var canCycle:bool = true
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

var selected:Array = []
signal playerActed

var recentAction:String

signal actionPressed

var checked = false
var onTurnIndex:int

func _ready() -> void:
	BattleGlobals.started.connect(_init_battle)
	
	
	for child in $enemies.get_children():
		child.queue_free()
		
	for child in $ui/party.get_children():
		child.queue_free()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		recentAction = "space"
		actionPressed.emit()
	
	if Input.is_action_just_pressed("ui_cancel"):
		recentAction = "escape"
		actionPressed.emit()
		
	if Input.is_action_just_pressed("ui_cancel") and skillmenu.visible:
		for i in $ui/btn.get_children():
			i.set_focus_mode(FOCUS_ALL)
			i.disabled = false
		
		for i in $ui/status/margin/skills/list.get_children():
			i.set_focus_mode(FOCUS_NONE)
			i.disabled = true
		
		
		$ui/btn/skill.grab_focus()
		skillmenu.visible = false
		text.visible = true

func _init_battle() -> void:
	canCycle = false
	visible = !visible
	
	text.append_text("[i]* FOES DRAW NEAR !! [/i]")
	text.newline()
	
	for enemy in BattleGlobals.enemyPool:
		
		var enemySprite = preload("res://scripts/battle/scenes/enemy.tscn").instantiate()
		enemySprite.texture_normal = enemy.texture 
		enemySprite.damageVal = enemy.damage 
		enemySprite.battleHandler = self
		$enemies.add_child(enemySprite)
		enemySprite.name = enemy.name
		text.append_text("   %s" % enemySprite.name)
		text.newline()
		enemySprite.health.max_value = enemy.health
		enemySprite.health.value = enemy.health
		
	BattleGlobals.enemyPool.clear()
	
	for member in BattleGlobals.party.size():
		
		var partyStatus = preload("res://scripts/battle/scenes/member.tscn").instantiate()
		partyStatus.portrait = BattleGlobals.party[member].texture
		partyStatus.battleHandler = self
		partyStatus.health = BattleGlobals.partyHealth[member]
		partyStatus.energy = BattleGlobals.partyEnergy[member]
		$ui/party.add_child(partyStatus)
		partyStatus.name = BattleGlobals.party[member].name
		partyStatus.healthbar.max_value = BattleGlobals.party[member].maxHealth
		partyStatus.energybar.max_value = BattleGlobals.party[member].maxEnergy
		
	
	_player_turn()
	


func _player_turn():
	if canCycle:
		return
		
	_enemy_check()
	print("enemy check at start of player turn")
	
	for i in $ui/btn.get_children():
		i.set_focus_mode(FOCUS_ALL)
		i.disabled = false
		
	for i in $enemies.get_children():
		i.set_focus_mode(FOCUS_NONE)
		i.disabled = true
		

	$ui/btn/fight.grab_focus()
	
	for member in $ui/party.get_children().size():
		_enemy_check()
		print("enemy check in party loop")
		

		
		
		for i in $ui/btn.get_children():
			i.set_focus_mode(FOCUS_ALL)
			i.disabled = false
		
		for i in $enemies.get_children():
			i.set_focus_mode(FOCUS_NONE)
			i.disabled = true
		
		$ui/btn/fight.grab_focus()
		
		
		onTurnIndex = member
		$ui/party.get_children()[member].anim.play("select")
		
		## draw skills
		for e in BattleGlobals.party[member].skills.size():
			var btn = preload("res://scripts/battle/scenes/button.tscn").instantiate()
			btn.partyIndex = member
			btn.skillIndex = e
			btn.battleHandler = self
			skillmenu.get_child(0).add_child(btn)
			btn.name = BattleGlobals.party[member].skills[e].skillName
		await playerActed
		$ui/party.get_children()[member].anim.stop()
		for e in skillmenu.get_child(0).get_children():
			e.queue_free()
	
	_enemy_turn()


func _enemy_check():
	if canCycle:
		return
	
	await get_tree().create_timer(.3).timeout
	if $enemies.get_children().is_empty() and !checked:
		canCycle = true
		checked = true
		text.newline()
		text.newline()
		text.append_text("[i] YOU WIN ! YOU GAIN JACK SHIT FUCKER ! [/i]")
		await get_tree().create_timer(5).timeout
		_battle_end()
		

func _enemy_turn():
	if canCycle:
		return
		
	_enemy_check()
	
	for i in $ui/btn.get_children():
		i.set_focus_mode(FOCUS_NONE)
		i.disabled = true
		
	for i in $enemies.get_children():
		i.set_focus_mode(FOCUS_NONE)
		i.disabled = true
	
	print("enemy check at start of enemy turn")
	
	if !$enemies.get_children().is_empty():
		for enemy in $enemies.get_children().size():
			$ui/party.get_children().pick_random().damage($enemies.get_child(enemy).damageVal,$enemies.get_child(enemy).name)
	
	_player_turn()


func _on_flee() -> void:
	playerActed.emit()
	_battle_end()


func _on_fight() -> void:
	
	_target_select(target.foe,BattleGlobals.party[onTurnIndex].attack,BattleGlobals.party[onTurnIndex].atkScaling,0)


func _battle_end():
	visible = !visible
	
	for child in $enemies.get_children():
		print("queue free", child.name)
		child.queue_free()
	
	for child in $ui/party.get_children():
		child.queue_free()
		
		
		
		
		
func _target_select(targeting:target, effect:int, scaling:float, cost:int):
	if canCycle:
		return
	
	var damageCalc = effect * (1 + (scaling * BattleGlobals.partyLevel))
	match targeting:
		0: #me
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
				
			$ui/party.get_child(onTurnIndex).updateStats("energy", cost)
			$ui/party.get_child(onTurnIndex).damage(damageCalc, $ui/party.get_child(onTurnIndex).name)
			playerActed.emit()
			return
		2: #friends
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
				
				
			
			for e in $ui/party.get_children():
				e.damage(damageCalc, $ui/party.get_child(onTurnIndex).name)
				
			$ui/party.get_child(onTurnIndex).updateStats("energy", cost)
			_enemy_check()
			playerActed.emit()
			return
		3: # foe
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_ALL)
				i.disabled = false
			
			if !$enemies.get_children().is_empty():
				$enemies.get_child(0).grab_focus()
		
		4: #foes
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
				
				
			
			for e in $enemies.get_children():
				e.damage(damageCalc, $ui/party.get_child(onTurnIndex).name)
			
			$ui/party.get_child(onTurnIndex).updateStats("energy", cost)
			_enemy_check()
			playerActed.emit()
			return
			
		7: # all
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
				
			
			var everyone:Array = $ui/party.get_children()
			everyone.append($enemies.get_children())
			for e in everyone:
				e.damage(damageCalc, $ui/party.get_child(onTurnIndex).name)
			
			$ui/party.get_child(onTurnIndex).updateStats("energy", cost)
			_enemy_check()
			playerActed.emit()
			return
		_: # fallback same as foe
			for i in $ui/btn.get_children():
				i.set_focus_mode(FOCUS_NONE)
				i.disabled = true
		
			for i in $enemies.get_children():
				i.set_focus_mode(FOCUS_ALL)
				i.disabled = false
			
			$enemies.get_child(0).grab_focus()
			
	
	await actionPressed
	print(recentAction)
	
	if recentAction == "space":
		
		match targeting:
			3: #foe
				for i in $enemies.get_children():
					if i.has_focus():
						i.damage(damageCalc, $ui/party.get_child(onTurnIndex).name)
						
		$ui/party.get_child(onTurnIndex).updateStats("energy", cost)
		_enemy_check()
		playerActed.emit()
	else:
		for i in $ui/btn.get_children():
			i.set_focus_mode(FOCUS_ALL)
			i.disabled = false
		
		for i in $enemies.get_children():
			i.set_focus_mode(FOCUS_NONE)
			i.disabled = true
	recentAction = ""
	
	


func _on_stuff_pressed() -> void:
	$ui/party.get_child(onTurnIndex).damage(-15,$ui/party.get_child(onTurnIndex).name)
	playerActed.emit()


func _on_skill_pressed() -> void:
	skillmenu.visible = true
	text.visible = false
	for i in $ui/btn.get_children():
		i.set_focus_mode(FOCUS_NONE)
		i.disabled = true
		
	for i in $ui/status/margin/skills/list.get_children():
		i.set_focus_mode(FOCUS_ALL)
		i.disabled = false
	
	$ui/status/margin/skills/list.get_child(0).grab_focus()
