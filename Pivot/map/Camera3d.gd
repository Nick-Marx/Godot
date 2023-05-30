extends Camera3D

@onready var target = PivotPlayer #what the camera follows
@export var smoothSpeed:float
@export var offset:Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	smooth_camera_follow(delta)


func smooth_camera_follow(delta):
	if(target != null): 
		self.transform.origin = lerp(self.transform.origin, target.transform.origin + offset, smoothSpeed * delta) #follows player smoothly every frame
