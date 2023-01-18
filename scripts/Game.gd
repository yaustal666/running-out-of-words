extends Node


onready var PauseMenu = $PauseMenu
onready var IngameUI = $IngameUI

onready var World = $World

onready var BookInterface = $BookInterface
onready var Input = $BookInterface/Wrapper/Input
onready var Letters = $BookInterface/Wrapper/Letters
onready var Message = $BookInterface/Wrapper/Message

func _ready():

	G.pause(true)

	PauseMenu.connect("resume", self, "resume")
	BookInterface.connect("wanna_close_book", self, "close_book")
	Input.connect("text_entered", self, "give_item")

	start_level()


func _input(event):

	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE:

			G.pause(true)

			IngameUI.hide()
			PauseMenu.show()


func start_level():

	G.pause(false)

	IngameUI.show()

	World.add_child(G.level)

	G.player.connect("wanna_open_book", self, "open_book")
	G.player.connect("wanna_take", self, "take_item")
	G.player.connect("wanna_put", self, "put_on_workbench")
	
	Letters.text = ""
	Letters.text += Config.get(""+G.level.get_meta("Label")+"_letters")

func resume():
	G.pause(false)
	PauseMenu.hide()
	IngameUI.show()


func open_book():

	G.pause(true)

	IngameUI.hide()
	BookInterface.show()


func close_book():

	G.pause(false)

	BookInterface.hide()
	IngameUI.show()


func give_item(item_name):

	var correct_letters = false

	for i in item_name:

		if Letters.text.find(i) == -1:
			correct_letters = false
			break

		correct_letters = true
	
	if ResourceLoader.exists("res://scenes/objects/"+item_name+".tscn") && correct_letters:

		# spawn item
		if World.get_node(G.item_spawn_path).get_child_count() != 0:
			World.get_node(G.item_spawn_path).remove_child(G.item)
		
		G.item = load("res://scenes/objects/"+item_name+".tscn").instance()
		World.get_node(G.item_spawn_path).add_child(G.item)
		# 

		# replacing spent letters
		var text = Letters.get_text()
		for i in item_name:
			var letter_index = text.find(i)
			if letter_index != -1:
				text[letter_index] = ""
		Letters.set_text(text)
		# 
		
		Message.text = "We give you "+item_name+""
		
	else:
		if correct_letters:
			Message.text = "Sorry but we don't have this one"
		else:
			Message.text = "You should make words using only given letters"
			
	Input.text = ""


func take_item(what):
	
	if(G.player.item != null):
		pass
	else:
		var parent = what.find_parent("*")
		parent.remove_child(what)
		what.get_node('CollisionShape').set_disabled(true)

		var player_item = G.player.get_node("Head/Item")
		player_item.add_child(what)
		player_item.set_meta("Label", what.get_meta("Label"))

		G.player.item = what

func put_on_workbench(what):
	
	var player_item = G.player.get_node("Head/Item")
	var workbench_item = World.get_node(G.workbench_item_path)
	
	
	if workbench_item.get_child_count() != 0:
		var probably_item = workbench_item.get_child(0).get_meta("Label") + "And" + player_item.get_meta("Label")

		if ResourceLoader.exists("res://scenes/objects/"+probably_item+".tscn"):
			player_item.remove_child(G.player.item)
			workbench_item.remove_child(G.workbench_item )
			
			G.workbench_item = load("res://scenes/objects/"+probably_item+".tscn").instance()
			workbench_item.add_child(G.workbench_item)
			
			G.player.item = null
			
	else:
		player_item.remove_child(what)
		player_item.set_meta("Label", "")
		G.player.item = null
		
		workbench_item.add_child(what)
		what.get_node('CollisionShape').set_disabled(false)
		G.workbench_item = what
