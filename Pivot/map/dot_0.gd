extends StaticBody3D


var pp #pivot_player object
var scoreBoard:Label
var greenDot:Mesh = load("res://material/green_dot.tres")
var whiteDot:Mesh = load("res://material/white_dot.tres")
var yellowDot:Mesh = load("res://material/yellow_dot.tres")
var redDot:Mesh = load("res://material/red_dot.tres")


func change_dot_color():
	if $MeshInstance3d.mesh == whiteDot:
		$MeshInstance3d.set_mesh(greenDot)
		scoreBoard.score += 1
	if $MeshInstance3d.mesh == yellowDot:
		$MeshInstance3d.set_mesh(greenDot)
		scoreBoard.score += 2
	if $MeshInstance3d.mesh == redDot:
		$MeshInstance3d.set_mesh(yellowDot)

func _ready():
	pp = get_node_or_null("../pivot_player")
	if pp != null:
		if global_position == pp.global_position:
			$MeshInstance3d.set_mesh(greenDot)
	scoreBoard = get_node_or_null("../Control/Score")

func _physics_process(delta):
#	if global_position == pp.global_position:
#		change_dot_color()
	pass
