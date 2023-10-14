extends DirectionalLight3D



@onready var pp = PivotPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.dL3d = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.visible:
		body.visible = false
#	print("entered camera: ", body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, body.visible, "\n", "\n")


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if !body.visible:
		body.visible = true
#	print("exited camera: ", body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, body.visible, "\n", "\n")

