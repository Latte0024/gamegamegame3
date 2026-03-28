extends Node2D

var players: Array = []
var index : int = 0

func _ready():
	players = get_children()
	for i in players.size():
		players[i].position = Vector2(i*64, 0)
