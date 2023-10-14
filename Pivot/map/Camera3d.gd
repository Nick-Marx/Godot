extends Camera3D


@onready var pp = PivotPlayer
#@onready var ppm1 = get_node("/root/pivot_map1")
var ppm1
@onready var target = get_node("/root/PivotPlayer/DirectionalLight3d")
#@onready var target = Global.dL3d
@export var smoothSpeed:float


# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_transform = target.global_transform
	self.current = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.global_position != target.global_position:
		smooth_camera_follow(delta)
	
	test_map_rotation()


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

func test_map_rotation():
	if !ppm1:
		ppm1 = Global.mainScene
		
	var verticalRot = target.global_transform.basis.x
	var horizontalRot = target.global_transform.basis.y
	
	if Input.is_action_just_pressed("ui_up"):
		pp.rotate(-verticalRot, PI/2)
		ppm1.build_map()

	if Input.is_action_just_pressed("ui_down"):
		pp.rotate(verticalRot, PI/2)
		ppm1.build_map()

	if Input.is_action_just_pressed("ui_right"):
		pp.rotate(horizontalRot, PI/2)
		ppm1.build_map()

	if Input.is_action_just_pressed("ui_left"):
		pp.rotate(-horizontalRot, PI/2)
		ppm1.build_map()
