extends StaticBody3D


@onready var pp = PivotPlayer
@export var speed:float = -0.0125 #holds rotation speed
var hiSpd:float = 0.05 #rot spd max
var loSpd:float = 0.0125 #rot spd min
const rotDir:int = -1 #used to change rotation direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_z(speed)

func change_rotation_dir():
	hiSpd *= rotDir
	loSpd *= rotDir



func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == pp.name:
		change_rotation_dir()
