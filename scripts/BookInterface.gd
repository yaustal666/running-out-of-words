extends Control

# rename signal
signal wanna_close_book

onready var Back = $Wrapper/Back
onready var Input = $Wrapper/Input

func _ready():
	Back.connect("pressed", self, "back")

func back():
	emit_signal("wanna_close_book")

