extends Label

var score:int = 0
var dot:StaticBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	dot = get_node_or_null("../dot_0")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Score: %s" % score
