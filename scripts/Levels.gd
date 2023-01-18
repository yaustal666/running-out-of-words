extends Control

onready var buttons = $Buttons

func _ready():

	for button in buttons.get_children():
		button.connect("pressed", self, "start_level", [button.text])
	$Back.connect("pressed", self, "back")


func start_level(level_name):
	level_name = level_name.replace(" ", "")
	G.level = load("res://levels/"+level_name+".tscn").instance()
	get_tree().change_scene("res://Game.tscn")

func back():
	get_tree().change_scene("res://ui/MainMenu.tscn")
