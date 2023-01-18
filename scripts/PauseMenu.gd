extends Control

signal resume

onready var buttons = $Buttons

func _ready():
	var count = 0
	var foo = ["resume", "main_menu"]
	
	for button in buttons.get_children():
		button.connect("pressed", self, foo[count])
		count += 1
	

func resume():
	emit_signal("resume")


func main_menu():
	get_tree().change_scene("res://ui/MainMenu.tscn")

