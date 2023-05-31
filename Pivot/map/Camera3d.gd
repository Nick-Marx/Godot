extends Camera3D


@onready var target = get_node("/root/PivotPlayer/DirectionalLight3d")
#@onready var target = PivotPlayer #what the camera follows
@export var smoothSpeed:float
#@export var offset:Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_transform = target.global_transform
	self.current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.global_position != target.global_position:
		smooth_camera_follow(delta)
	
	if Input.is_action_just_pressed("ui_down"):
		PivotPlayer.rotate_x(-PI/2)
		


func smooth_camera_follow(delta):
	if !self.current:
		self.current = true
	if(target != null):
		self.global_transform = self.global_transform.interpolate_with(target.global_transform, smoothSpeed * delta)
#		self.transform.origin = lerp(self.transform.origin, target.transform.origin + offset, smoothSpeed * delta) #follows player smoothly every frame

#		var target_xform = target.global_transform.translated_local(offset)
#		global_transform = global_transform.interpolate_with(target_xform, smoothSpeed * delta)
#		look_at(target.global_transform.origin, target.transform.basis.y)
#		print(self.global_transform," ", mainCam.global_transform)


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
