extends KinematicBody

signal wanna_open_book
signal wanna_take(what)
signal wanna_use
signal wanna_put(what)

onready var Head = $Head
onready var Ray = $Head/Camera/Ray
onready var Item = $Head/Item

var speed = 1
var direction = Vector3()

var horizonal_sens = 0.02
var vertical_sens = 0.02

var cast = null
var item = null

func _ready():
	G.player = self


func _physics_process(delta):
	
	direction.x = 0
	direction.z = 0

	if Input.is_action_pressed("MoveForward"):
		direction.z = -speed
	if Input.is_action_pressed("MoveBack"):
		direction.z = speed
	if Input.is_action_pressed("MoveLeft"):
		direction.x = -speed
	if Input.is_action_pressed("MoveRight"):
		direction.x = speed

	if Input.is_action_pressed("Run"):
		pass
	
	direction.y -= 1

	if direction.x || direction.z:
		direction = direction.rotated(Vector3.UP, rotation.y)
	
	direction  = move_and_slide(direction, Vector3.UP)

	cast = Ray.get_collider()


func action_left():

	if cast != null:

		if cast.has_meta("LevelItem"):
			emit_signal("wanna_use")
		
		if cast.has_meta("Label"):
			if cast.get_meta("Label") == "Book":
				emit_signal("wanna_open_book")
			if cast.get_meta("Label") == "Workbench, you can put an item here":
				if item != null:
					emit_signal("wanna_put", item)
		
		if cast.has_meta("Take"):
			emit_signal("wanna_take", cast)

func action_right():
	if Item.get_child_count() != 0:
		Item.remove_child(item)
		Item.remove_meta("Label")
		item = null

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * 0.005
		Head.rotation.x = clamp(Head.rotation.x - event.relative.y * 0.005, -1.4, 1.4)
	
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT: # add action right for removing items
				action_left()
			if event.button_index == BUTTON_RIGHT:
				action_right()
