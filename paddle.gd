extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum CONTROLS{
CONTROL_LEFT, CONTROL_RIGHT
}

export var paddle_color = Color()
export var paddle_size = Vector2()
export var paddle_speed = 5.0
export var paddle_computer = true
export(int, "left", "right" ) var paddle_side
export(int, "wasd", "arrow_keys") var control_type

onready var draw_paddle = get_node( "draw_paddle" )
onready var paddle_collider = get_node( "paddle_collider" )

var paddle_pos = Vector2()

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
	move_to( paddle_pos )
	set_fixed_process( true )

func _fixed_process(delta):
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
	move_to( paddle_pos )
