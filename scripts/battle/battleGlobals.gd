extends Node

## Array of node names checked by encounter nodes to check if they shoudl appear or not
## [br][br]
## [b]Note:[/b] name of encounter nodes is VERY important as i suck at coding and thus they only add their name to this array
## and if any arrays have duplicate names they will both dissapear if you on encounter one of themly
## [br][br]
## naming convention i use: encounter + name of room + number of encounter

var defeatedEncounters:Array[String] = []

var enemyPool:Array[enemyData] = []


## Hey jimmy gimme the longest fucking line you have

var party:Array[partyMember] = [preload("res://scripts/battle/resources/party/raul_placeholder.tres"),preload("res://scripts/battle/resources/party/raul_placeholder.tres"),preload("res://scripts/battle/resources/party/raul_placeholder.tres")]

signal started


## this is thje worst possible implementation that works but i cant be fucking bothered im sorry

var partyHealth:Array[int] = [66,54,88]
var partyEnergy:Array[int] = [100,15,50]
var partyLevel:int =  5
