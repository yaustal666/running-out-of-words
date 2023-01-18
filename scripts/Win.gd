extends Control


func _ready():
	
	$Buttons/MainMenu.connect("pressed", self, "main_menu")
	$Buttons/Levels.connect("pressed", self, "levels")

func main_menu():
	get_tree().change_scene("res://ui/MainMenu.tscn")

func levels():
	get_tree().change_scene("res://ui/Levels.tscn")