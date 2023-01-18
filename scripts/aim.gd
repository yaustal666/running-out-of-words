extends ColorRect

onready var TargetName = $TargetName

func _process(delta):
	
	var cast = G.player.cast

	if is_instance_valid(cast) && cast.has_meta("Label"):
		TargetName.text = cast.get_meta("Label")
	else:
		TargetName.text = ""
