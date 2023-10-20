extends Node3D


var greenDot:Mesh = load("res://material/green_dot.tres")
var whiteDot:Mesh = load("res://material/white_dot.tres")
var yellowDot:Mesh = load("res://material/yellow_dot.tres")
var redDot:Mesh = load("res://material/red_dot.tres")

@onready var meshNode = $Area3DOuter/MeshInstance3d

var isActive:bool = false
var isInnerActive:bool = false


func change_dot_color():
	if meshNode.mesh == whiteDot:
		meshNode.set_mesh(greenDot)
		Global.score += 1
	if meshNode.mesh == yellowDot:
		meshNode.set_mesh(greenDot)
		Global.score += 3
	if meshNode.mesh == redDot:
		meshNode.set_mesh(yellowDot)

func _on_area_3d_outer_area_entered(area):
	Signals.dotOuterEntered.emit(self, area)

func _on_area_3d_outer_area_exited(area):
	Signals.dotOuterExited.emit(self, area)
	
func _on_area_3d_inner_area_entered(area):
	Signals.dotInnerEntered.emit(self, area)

func _on_area_3d_inner_area_exited(area):
	Signals.dotInnerExited.emit(self, area)


