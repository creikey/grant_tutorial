extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum direction {
UP, DOWN, STATIC
}

export var paddle_color = Color()
export var paddle_size = Vector2()
export var paddle_speed = 5.0
export var paddle_computer = true
export var ball_path = ""
export(int, "left", "right" ) var paddle_side
export(int, "wasd", "arrow_keys") var control_type

onready var ball = get_node( ball_path )
onready var draw_paddle = get_node( "draw_paddle" )
onready var paddle_collider = get_node( "paddle_collider" )

var ball_pos = Vector2()
var paddle_pos = Vector2()
var to_direction = direction.STATIC
var difficulty = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if( draw_paddle == null ):
		breakpoint
	draw_paddle.set_paddle_color( paddle_color )
	draw_paddle.set_paddle_size( paddle_size )
	if( paddle_side == 0 ):
		paddle_pos.x = 0
	elif( paddle_side == 1 ):
		paddle_pos.x = OS.get_window_size().x-paddle_size.x
	paddle_pos.y = OS.get_window_size().y/2
	paddle_collider.get_shape().set_extents( paddle_size )
	paddle_collider.set_pos( paddle_size/2 )
	randomize()
	difficulty = randf()+0.5
	if( difficulty > ball.get_ball_speed() ):
		difficulty = ball.get_ball_spee()-0.1
	move_to( paddle_pos )
	set_fixed_process( true )

func _fixed_process(delta):
	if( paddle_computer == false ):
		if( control_type == 0 ):
			if( Input.is_key_pressed( KEY_W ) ):
				paddle_pos.y -= paddle_speed
			if( Input.is_key_pressed( KEY_S ) ):
				paddle_pos.y += paddle_speed
		elif( control_type == 1 ):
			if( Input.is_key_pressed( KEY_UP ) ):
				paddle_pos.y -= paddle_speed
			if( Input.is_key_pressed( KEY_DOWN ) ):
				paddle_pos.y += paddle_speed
		if( paddle_pos.y > OS.get_window_size().y-paddle_size.y ):
			paddle_pos.y = OS.get_window_size().y-paddle_size.y
		if( paddle_pos.y < 0 ):
			paddle_pos.y = 0
	else:
		ball_pos = ball.get_global_pos()
		if( ball_pos.y > paddle_pos.y+paddle_size.y/2 ):
			to_direction = direction.DOWN
		elif( ball_pos.y < paddle_pos.y+paddle_size.y/2  ):
			to_direction = direction.UP
		else:
			to_direction = direction.STATIC
		if( to_direction == direction.UP ):
			paddle_pos.y -= paddle_speed*(difficulty)
			print( "Changing the paddle_pos to ", paddle_pos )
		if( to_direction == direction.DOWN ):
			paddle_pos.y += paddle_speed*(difficulty)
			print( "Changing the paddle_pos to ", paddle_pos )
		if( to_direction == direction.STATIC ):
			pass
		if( paddle_pos.y > OS.get_window_size().y-paddle_size.y ):
			paddle_pos.y = OS.get_window_size().y-paddle_size.y
		if( paddle_pos.y < 0 ):
			paddle_pos.y = 0
	move_to( paddle_pos )

func pos_in_bounds( in_pos ):
	#print( "Checking pos %d is in bounds of %d and %d" % [in_pos, paddle_pos.y, paddle_pos.y+paddle_size.y] )
	if( in_pos < paddle_pos.y+paddle_size.y and in_pos > paddle_pos.y ):
		return true
	return false

func get_paddle_size():
	return paddle_size
