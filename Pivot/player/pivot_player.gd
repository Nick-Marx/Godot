extends Node3D


@onready var pp = $Area3D
#@export var dL3d:DirectionalLight3D
@export var speed:float = -0.025 #holds rotation speed
var hiSpd:float = -0.055 #rot spd max
var loSpd:float = -0.025 #rot spd min
const rotDir:int = -1 #used to change rotation direction
var innerActive:bool = false #?true if player touching dot center
var currentDotTouching #holds object of dot overlapping player tip
@onready var prevDotPos #holds players prev glob pos after movign to new dot
var rand = RandomNumberGenerator.new()
var didBuildMap:bool = true



func _ready():
	Global.player = self
	
	Signals.dotOuterEntered.connect(dotOuterEntered)
	Signals.dotOuterExited.connect(dotOuterExited)
	Signals.dotInnerEntered.connect(dotInnerEntered)
	Signals.dotInnerExited.connect(dotInnerExited)
	
	Signals.bumperEntered.connect(bumperEntered)
	Signals.spinnerEntered.connect(spinnerEntered)
	#print(name)

func change_rotation_dir():
	hiSpd *= rotDir
	loSpd *= rotDir

func _physics_process(delta):
	pp.rotate_z(speed)
	
	if Input.is_action_just_pressed("action_one") or Input.is_action_pressed("action_one"):
		player_movement(currentDotTouching)

#	printt(pp.global_position, $DirectionalLight3d.name, $DirectionalLight3d.global_position)

#ctrl move and spd of player from one dot to another
func player_movement(currentDot):
#	printt(prevDot, currentDot)
	if !currentDot or currentDot.global_position == prevDotPos:
		return
	if currentDot and currentDot.isActive:
#		print("dot in ", body.name)
#		printt(prevDot, currentDot)
		pp.rotate_z(PI)
		prevDotPos = self.global_position
#		printt(prevDot)
		self.global_position = currentDot.global_position
		self.change_rotation_dir()
		self.speed = loSpd #sets player speed to low and changes direction
		if currentDot.isInnerActive:
			speed = hiSpd
		currentDot.change_dot_color()
		didBuildMap = false
	

func dotOuterEntered(currentDot, area):
	if area.is_in_group("Gplayer"):
		currentDot.isActive = true
		currentDotTouching = currentDot

func dotOuterExited(currentDot, area):
	if area.is_in_group("Gplayer"):
		currentDot.isActive = false
		currentDotTouching = null
	if currentDot.global_position == prevDotPos:
		prevDotPos = self.global_position

func dotInnerEntered(currentDot, area):
	if area.is_in_group("Gplayer"):
		currentDot.isInnerActive = true

func dotInnerExited(currentDot, area):
	if area.is_in_group("Gplayer"):
		currentDot.isInnerActive = false

func bumperEntered(bumper, area):
	if area.is_in_group("Gplayer"):
		self.change_rotation_dir()
		self.speed = hiSpd
	
func spinnerEntered(spinner, area):
	if area.is_in_group("Gplayer"):
		self.change_rotation_dir()
		self.speed = loSpd
