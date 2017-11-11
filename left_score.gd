extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var ball = get_node( "../ball" )
var side_score = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	update_text()

func update_text():
	set_text( "left score: %d" % [side_score] )

func _on_ball_out_of_bounds( side ):
	if( side == false ):
		side_score += 1
		update_text()

