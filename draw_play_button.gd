extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var draw_font = "default.fnt"
export var to_draw = "test"
export var font_color = Color()
export var outline_color = Color()
export var next_scene_path = ""

onready var font = get_font( draw_font )

var font_offset = Vector2()
var font_pos = Vector2()
var index = 0
var draw_outline = false
var size_set = false
var draw_red_outline = false
var goto_scene_counter = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_focus_mode( FOCUS_ALL )
	pass

func _input_event(ev):
	if( ev.type == InputEvent.MOUSE_BUTTON and ev.pressed ):
		print( "Control pressed!" )
	if( ev.type == InputEvent.MOUSE_MOTION ):
		print( "Control detected mouse movement!" )
		draw_outline = true
		goto_scene_counter += 1
		update()
	else:
		if( draw_outline == true ):
			draw_outline = false
			update()

func _draw():
	if( goto_scene_counter > 10 ):
		get_tree().change_scene( next_scene_path )
	index = 0
	font_pos = Vector2(0,font.get_height())
	if( draw_outline ):
		print( "Drawing outline at ", Rect2( font_pos, font_offset ) )
		draw_rect( Rect2( font_pos, Vector2(font_offset.x, font_offset.y*-1) ), outline_color )
		
	while( index+1 < to_draw.length() ):
		font_pos.x += draw_char( font, font_pos, get_char(to_draw.ord_at(index)), get_char(to_draw.ord_at(index+1)), font_color )
		#print( "Drawing text at ", font_pos )
		#print( "Drawing char ", get_char(to_draw.ord_at(index)) )
		index += 1
	font_pos.x += draw_char( font, font_pos, get_char(to_draw.ord_at(index)), get_char(to_draw.ord_at(index)), font_color )
	font_offset.x = font_pos.x
	font_offset.y = font.get_height()
	#draw_rect( Rect2( Vector2(), font_offset ), Color(255,0,0) )
	if( size_set == false ):
		set_size( font_offset )
		print( "Control size is: ", get_size() )
		size_set = true


func get_font_offset():
	return font_offset

func get_char( in_int ):
	var bla = RawArray([in_int])
	return(bla.get_string_from_utf8())
