extends Camera3D

@onready var target = PivotPlayer #what the camera follows
@export var smoothSpeed:float
@export var offset:Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	smooth_camera_follow(delta)
	
	if Input.is_action_just_pressed("ui_down"):
		target.rotate_x(-PI/2)
		


func smooth_camera_follow(delta):
	if(target != null):
		self.transform.origin = lerp(self.transform.origin, target.transform.origin + offset, smoothSpeed * delta) #follows player smoothly every frame

#		var target_xform = target.global_transform.translated_local(offset)
#		global_transform = global_transform.interpolate_with(target_xform, smoothSpeed * delta)
#		look_at(target.global_transform.origin, target.transform.basis.y)





func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == PivotPlayer.get_child(0).name:
		return
	if body.visible:
		body.visible = false
#	print("entered camera: ", body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, body.visible, "\n", "\n")


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if !body.visible:
		body.visible = true
#	print("exited camera: ", body_rid, "\n", body, "\n", body_shape_index, "\n", local_shape_index, body.visible, "\n", "\n")
