extends KinematicBody

#register class name for easier referencing
class_name pivot_player

# Declare member variables here.
export var speed = 0.03125

#keep track of rotation direction. false = clockwise
var rotationDirection = false
#var used to track rigbody current translate to flip it after each jump


#fn for switching rotation direction
func rotation_direction_change():
	#change speed variable based on rotationDirection
	if rotationDirection == false:
		speed *= -1
		rotationDirection = true
	else:
		speed *= -1
		rotationDirection = false

func move_pivot_player(location):
	#move player to dot pos
	global_translate(location)
	#flip player
	global_rotate(Vector3(0,0,1), PI)
	#change rotation direction
	rotation_direction_change()
	#for debugging
	print("player moved")
#fn to flip player
#func flip_player():
#	#flip pivot's orientation
#	if getRigBodyLocation == 2:
#		getRigBodyLocation = 0
#	else:
#		getRigBodyLocation = 2
	

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_direction_change()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#constantly rotates player. start clockwise
	rotate_z(speed)
	#move_pivot_player()
	
	
		
		#
		
