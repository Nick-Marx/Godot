extends CharacterBody3D


@export var speed:float = -0.0125
var hiSpd:float = 0.05
var loSpd:float = 0.0125
const rotDir:int = -1
var isActive:bool = false
var innerActive:bool = false
var activeBody
var prevDotPos


func _ready():
	prevDotPos = global_position
	print(name)

func change_rotation_dir():
	hiSpd *= rotDir
	loSpd *= rotDir

func _physics_process(delta):
	rotate_z(speed)
	
	if innerActive:
		inner_dot_action_press(activeBody)
		isActive = false
	if isActive and !innerActive:
		outer_dot_action_press(activeBody)
		isActive = false


	
func outer_dot_action_press(body):
	if body.global_position == prevDotPos:
		return
	if Input.is_action_just_pressed("action_one") or Input.is_action_pressed("action_one"):
		global_position = body.global_position
		rotate_z(PI)
		change_rotation_dir()
		speed = loSpd #sets player speed to low and changes direction
		print("outer: ", global_position)
	
func inner_dot_action_press(body):
	if body.global_position == prevDotPos:
		return
	if Input.is_action_just_pressed("action_one"):
		global_position = body.global_position
		rotate_z(PI)
		change_rotation_dir()
		speed = hiSpd #sets player speed to low and changes direction
		print("inner: ", global_position)
	

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == name:
		return
	if body_shape_index == 0:
		isActive = true
		activeBody = body
	if body_shape_index == 1:
		innerActive = true
		
#	print(body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, "\n", "\n")


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body_shape_index == 1:
		innerActive = false
	if local_shape_index == 0:
		isActive = false
		activeBody = null
	if body_shape_index == 0 and body.global_position == prevDotPos:
		prevDotPos = global_position
