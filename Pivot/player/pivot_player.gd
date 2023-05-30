extends CharacterBody3D


@export var speed:float = -0.0125 #holds rotation speed
#@onready var map = load("res://map/pivot_map1.gd") #holds map1 node - tentative
var hiSpd:float = 0.05 #rot spd cieling
var loSpd:float = 0.0125 #rot spd floor
const rotDir:int = -1 #used to change rotation direction
var isActive:bool = false #?true if player currently overlapping a dot
var innerActive:bool = false #?true if player touching dot center
var activeBody #holds object of currently overlapping dot
@onready var passedDotPos:Vector3 #holds glob pos of prev touched dot
var rand = RandomNumberGenerator.new()
var didMove:bool = false



func _ready():
	#print(name)
	pass

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

#ctrl move and spd of player from one dot to another
func outer_dot_action_press(body):
	if body.global_position == passedDotPos:
		return
	if Input.is_action_just_pressed("action_one") or Input.is_action_pressed("action_one"):
		self.global_position = body.global_position
		rotate_z(PI)
		speed = loSpd #sets player speed to low and changes direction
		change_rotation_dir()
		body.change_dot_color()
		didMove = true
		#print("outer: ", global_position)

#ctrl move and spd of player from one dot to another
func inner_dot_action_press(body):
	if body.global_position == passedDotPos:
		return
	if Input.is_action_just_pressed("action_one") or Input.is_action_pressed("action_one"):
		self.global_position = body.global_position
		rotate_z(PI)
		speed = hiSpd #sets player speed to low and changes direction
		change_rotation_dir()
		body.change_dot_color()
		didMove = true #sets whether player has recently moved
		#print("inner: ", global_position)

#signal gathers info on overlapping dot
func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == name:
		return
	if body_shape_index == 0:
		isActive = true
		activeBody = body
	if body_shape_index == 1:
		innerActive = true
		
#	print(body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, "\n", "\n")

#runs cleanup when no longer overlapping dot
func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body_shape_index == 1:
		innerActive = false
	if local_shape_index == 0:
		isActive = false
		activeBody = null
	if body_shape_index == 0 and body.global_position == passedDotPos:
		passedDotPos = global_position
			
