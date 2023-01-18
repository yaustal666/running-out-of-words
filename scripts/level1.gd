extends Spatial

var is_door_open = false

onready var Door = $Door

func _ready():
	G.player.connect("wanna_use", self, "use")

func use():
	
	var use_on = G.player.cast.get_meta("Label")
	var use_item = G.player.get_node("Head/Item").get_meta("Label")

	if use_on == "Door" && use_item == "Key":
		if !is_door_open:
			Door.get_node("AnimationPlayer").play("default")
			is_door_open = true
		
