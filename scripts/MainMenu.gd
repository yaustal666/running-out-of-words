extends Control

onready var buttons = $Buttons

func _ready():
	var count = 0
	var foo = ["newGame", "levels", "exit"]
	for button in buttons.get_children():
		button.connect("pressed", self, foo[count])
		count += 1
	

func newGame():
	G.level = load("res://levels/level0.tscn").instance()
	get_tree().change_scene("res://Game.tscn")

# add levels menu on right side
func levels():
	get_tree().change_scene("res://ui/Levels.tscn")


func exit():
	get_tree().quit()

