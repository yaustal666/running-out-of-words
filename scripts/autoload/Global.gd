extends Node

var player 
var level 
var item
var workbench_item

var item_spawn_path = "Level/Room/Table/Item"
var workbench_item_path = "Level/Room/Workbench/Item"

func _ready():
	pass

func pause(p=true):
	get_tree().paused = p
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if !p else Input.MOUSE_MODE_VISIBLE)
