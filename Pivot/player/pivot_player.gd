extends CharacterBody3D


@export var speed:float = -0.0125



func change_direction():
	speed *= -1

func _physics_process(delta):
	rotate_z(speed)
