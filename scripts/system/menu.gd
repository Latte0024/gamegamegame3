extends Control

signal closed
signal opened

var InvOpen : bool = false



func _input(_event):
	if get_tree().paused == true and InvOpen == false:
		return
	if Input.is_action_pressed("menu"):
		opened.emit()
	if Input.is_action_pressed("close"):
		closed.emit()

func _on_opened():
	visible = true
	get_tree().paused = true
	InvOpen = true

func _on_closed():
	visible = false
	get_tree().paused = false
	InvOpen = false
