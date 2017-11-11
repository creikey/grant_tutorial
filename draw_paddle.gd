extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var paddle_size = Vector2()
var paddle_color = Color()

var paddle_pos = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _draw():
	draw_rect( Rect2( paddle_pos, paddle_size ), paddle_color )

func set_paddle_color( in_color ):
	paddle_color = in_color

func set_paddle_size( in_size ):
	paddle_size = in_size
