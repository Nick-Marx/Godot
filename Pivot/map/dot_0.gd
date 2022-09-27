extends StaticBody3D


var pp #pivot_player object
var greenDot:Mesh = load("res://material/green_dot.tres")


func change_dot_color():
	if $MeshInstance3d.mesh != greenDot:
		$MeshInstance3d.set_mesh(greenDot)

func _ready():
	pp = get_node_or_null("../pivot_player")
	if pp != null:
		if global_position == pp.global_position:
			$MeshInstance3d.set_mesh(greenDot)
			

func _physics_process(delta):
	if global_position == pp.global_position:
		change_dot_color()
