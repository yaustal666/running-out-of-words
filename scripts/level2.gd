extends Spatial

var is_door_open = false
var screws = 4

onready var Door = $Door
onready var Vent = $Room/Vent

func _ready():
	G.player.connect("wanna_use", self, "use")
	
		
func use():
	
	var use_on_name = G.player.cast.get_meta("Label")
	var use_on = G.player.cast
	var use_item = G.player.get_node("Head/Item").get_meta("Label")

	if use_on_name == "Door" && use_item == "Key":
		if !is_door_open:
			Door.get_node("AnimationPlayer").play("default")
			is_door_open = true
	
	print_debug(use_on_name)
	print_debug(use_item)
	
	if use_on_name == "Screw" && use_item == "ScrewdriverAndBattery":
		var anim = use_on.get_node("AnimationPlayer")
			
		use_on.queue_free()
		screws -= 1
		
		print_debug(screws)
		
		if screws == 0:
			Vent.queue_free()
