extends KinematicBody


# Declare member variables here.
export var speed = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_z(-speed)
	
