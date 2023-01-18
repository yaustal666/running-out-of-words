extends Spatial

onready var StrangeWallPiece = $PartOfWall

func _ready():
	G.player.connect("wanna_use", self, "use")

func use():
	
	var use_on = G.player.cast.get_meta("Label")
	var use_item = G.player.get_node("Head/Item").get_meta("Label")
	
	print_debug(use_on)
	print_debug(use_item)

	if use_on == "StrangeWallPiece" && use_item == "Pickaxe":
		StrangeWallPiece.queue_free()
