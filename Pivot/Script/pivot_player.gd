extends KinematicBody


# Declare member variables here.
export var speed = 0.5
#keep track of rotation direction. false = clockwise
var rotationDirection = false

#fn for switching rotation direction
func rotation_direction_change():
	#change speed variable based on rotationDirection
	if rotationDirection == false:
		speed *= -1
		rotationDirection = true
	else:
		speed *= -1
		rotationDirection = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_direction_change()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#constantly rotates player. start clockwise
	rotate_z(speed)
	
	#if btn pressed and dot collider overlap -> get dot pos, move player to dot pos, flip player, change rot direction
	#if Input.is_action_pressed("action_one") and :
		#
		
