extends StaticBody3D


var scoreBoard:Label
var greenDot:Mesh = load("res://material/green_dot.tres")
var whiteDot:Mesh = load("res://material/white_dot.tres")
var yellowDot:Mesh = load("res://material/yellow_dot.tres")
var redDot:Mesh = load("res://material/red_dot.tres")

var isActive:bool = false
var isInnerActive:bool = false


func change_dot_color():
	scoreBoard = get_node_or_null("../Control/Score")
	if $MeshInstance3d.mesh == whiteDot:
		$MeshInstance3d.set_mesh(greenDot)
		scoreBoard.score += 1
	if $MeshInstance3d.mesh == yellowDot:
		$MeshInstance3d.set_mesh(greenDot)
		scoreBoard.score += 3
	if $MeshInstance3d.mesh == redDot:
		$MeshInstance3d.set_mesh(yellowDot)


func _on_area_3d_outer_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	Signals.emit_signal("dotOuterEntered", self, body)
	Signals.dotOuterEntered.emit(self, body)


func _on_area_3d_outer_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
#	Signals.emit_signal("dotOuterExited", self, body)
	Signals.dotOuterExited.emit(self, body)


func _on_area_3d_inner_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	Signals.emit_signal("dotInnerEntered", self, body)
	Signals.dotInnerEntered.emit(self, body)

func _on_area_3d_inner_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
#	Signals.emit_signal("dotInnerExited", self, body)
	Signals.dotInnerExited.emit(self, body)
