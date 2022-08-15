extends KinematicBody


# Declare member variables here.
export var speed = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#constantly rotates player. start clockwise
	rotate_z(-speed)
	
	#if btn pressed and dot collider overlap -> get dot pos, move player to dot pos, flip player, change rot direction
	#if Input.is_action_pressed("action_one") and :
		#
		
