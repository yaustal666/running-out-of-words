extends Spatial

onready var area = $Area

func _ready():
	area.connect("body_entered", self, "complete_level")


func complete_level(player):
	G.pause(true)
	get_tree().change_scene("res://ui/Win.tscn")