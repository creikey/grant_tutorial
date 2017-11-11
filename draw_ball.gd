extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ball_size = 0.0
var ball_color = Color()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_ball_color( in_color ):
	ball_color = in_color

func set_ball_size( in_size ):
	ball_size = in_size
