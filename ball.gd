extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal out_of_bounds

export var ball_color = Color()
export var ball_size = 0.0
export var ball_speed = Vector2()
export var right_paddle_name = ""
export var left_paddle_name = ""

onready var draw_ball = get_node( "draw_ball" )
onready var right_paddle = get_node( right_paddle_name )
onready var left_paddle = get_node( left_paddle_name )
onready var right_paddle_pos = right_paddle.get_pos()
onready var left_paddle_pos = left_paddle.get_pos()
onready var left_paddle_size = left_paddle.get_paddle_size()

onready var pos = get_pos()

func get_ball_speed():
	return abs(ball_speed)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if( right_paddle == null or left_paddle == null ):
		print( "left or right paddle null for ball" )
		breakpoint
	draw_ball.set_ball_color( ball_color )
	draw_ball.set_ball_size( ball_size )
	move_to( OS.get_window_size()/2 )
	set_fixed_process( true )

func _fixed_process( delta ):
	pos = get_pos()
	right_paddle_pos = right_paddle.get_pos()
	left_paddle_size = left_paddle.get_paddle_size()
	left_paddle_pos = left_paddle.get_pos()
	if( pos.y-ball_size < 0  or pos.y+ball_size > OS.get_window_size().y ):
			ball_speed.y *= -1
	if( pos.x+ball_size > right_paddle_pos.x and right_paddle.pos_in_bounds(pos.y) or pos.x-ball_size < left_paddle_pos.x+left_paddle_pos.x and left_paddle.pos_in_bounds(pos.y) ):
			ball_speed.x *= -1
	else:
		if( pos.x-ball_size < 0 ):
			emit_signal( "out_of_bounds", true )
			move_to( OS.get_window_size()/2)
		elif( pos.x+ball_size > OS.get_window_size().x ):
			emit_signal( "out_of_bounds", false )
			move_to( OS.get_window_size()/2)
		
	move( ball_speed )

