extends CharacterBody3D


@export var speed:float = -0.0125
const spdCtrl:int = 4
const rotDir:int = -1



func _physics_process(delta):
	rotate_z(speed)
