extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var draw_node = get_node( "pong_button_draw")

export var initial_speed = 0.0
var vel = Vector2()

var max_pos = OS.get_window_size()
var min_pos = Vector2()

var bounding_box = Rect2()
var mouse_pos = Vector2()
var bottom_right_corner = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if draw_node == null:
		breakpoint;
	vel.x = initial_speed
	vel.y = initial_speed
	set_fixed_process( true )

func _fixed_process(delta):
	bounding_box.pos = get_pos()
	mouse_pos = get_global_mouse_pos()
	bounding_box.size = draw_node.get_font_offset()
	bottom_right_corner = bounding_box.pos + bounding_box.size
	#print( "Bounding box is ", bounding_box )
	if( bounding_box.pos.x < min_pos.x or bottom_right_corner.x > max_pos.x ):
		vel.x *= -1
	if( bottom_right_corner.y > max_pos.y or bounding_box.pos.y < min_pos.y ):
		vel.y *= -1
	#if( mouse_pos.x < bottom_right_corner.x && mouse_pos.x > bounding_box.pos.x ):
	#	if( mouse_pos.y > bounding_box.pos.y && mouse_pos.y < bottom_right_corner.y ):
	#		draw_node.set_draw_outline( true )
	#		draw_node.update()
	#else:
	#	draw_node.set_draw_outline( false )
	#draw_node.update()
	move( vel )
