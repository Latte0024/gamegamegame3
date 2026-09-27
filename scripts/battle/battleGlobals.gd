extends Node

## Array of node names checked by encounter nodes to check if they shoudl appear or not
## [br][br]
## [b]Note:[/b] name of encounter nodes is VERY important as i suck at coding and thus they only add their name to this array
## and if any arrays have duplicate names they will both dissapear if you only encounter one of them
## [br][br]
## naming convention i use: encounter + name of room + number of encounter
## = written by zeronic

var defeatedEncounters:Array[String] = []

var enemyPool:Array[enemyData] = []




var party:Array[partyMember] = [preload("res://scripts/battle/resources/party/Charlotte.tres"),preload("res://scripts/battle/resources/party/Mike.tres"),preload("res://scripts/battle/resources/party/Zuri.tres")]

signal started


## not the best implementation but whatever

var partyHealth:Array[int] = [11,1,1]
var partyEnergy:Array[int] = [100,15,50]
var partyLevel:int =  5
var dead: Array[bool] = [false, false, false]
var partyLocation : Vector2
