extends Node3D


@onready var pp: Area3D = $Area3D
@onready var dL3d:DirectionalLight3D = $DirectionalLight3d

@export var playerTrail: PackedScene
var trailDict: Dictionary = {}

@export var speed: float #holds rotation speed
var hiSpd: float #rot spd max
var loSpd: float #rot spd min

const rotDir: int = -1 #used to change rotation direction

var innerActive: bool = false #?true if player touching dot center

var currentDotTouching: Node3D #holds object of dot overlapping player tip
@onready var prevDotPos: Vector3 #holds players prev glob pos after movign to new dot

var rand = RandomNumberGenerator.new()

var didBuildMap: bool = true

var debug_mapRotation: bool = false


func _ready() -> void:
	Global.player = self
	
	hiSpd = speed * 2
	loSpd = speed
	
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

func _physics_process(delta: float) -> void:
	pp.rotate_z(speed)
	
	if Input.is_action_just_pressed("action_one") or Input.is_action_pressed("action_one"):
		if !Global.menu.visible:
			player_movement(currentDotTouching)
	
	if !Global.isScenePaused and Global.pivotWheel.value == 8 or debug_mapRotation == true:
		map_rotation()

	if Input.is_action_pressed("ui_home"):
		debug_mapRotation = true

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
		place_player_trail(trailPosCalc(currentDot.global_position, prevDotPos))


func map_rotation():
	var verticalRot = dL3d.global_transform.basis.x
	var horizontalRot = dL3d.global_transform.basis.y
	
	if Input.is_action_just_pressed("up_dir"):
		self.rotate(-verticalRot, PI/2)
		didBuildMap = false
		Global.pivotWheel.value = 0

	if Input.is_action_just_pressed("down_dir"):
		self.rotate(verticalRot, PI/2)
		didBuildMap = false
		Global.pivotWheel.value = 0

	if Input.is_action_just_pressed("right_dir"):
		self.rotate(horizontalRot, PI/2)
		didBuildMap = false
		Global.pivotWheel.value = 0

	if Input.is_action_just_pressed("left_dir"):
		self.rotate(-horizontalRot, PI/2)
		didBuildMap = false
		Global.pivotWheel.value = 0


func place_player_trail(tempPos: Vector3):
	if !trailDict.has(tempPos):
		trailDict[tempPos] = null
		
	if trailDict[tempPos] == null:
		var tempTrail = playerTrail.instantiate() #instantiate packed scene as a node
		tempTrail.set_name("trail%s" % tempPos)
		Global.trailOrganizer.add_child(tempTrail) #adds node to tree as child of organizer node
		tempTrail.global_position = tempPos
#		tempTrail.global_rotation = self.global_rotation
		
		if int(tempPos.x) % 2 != 0:
			tempTrail.rotate_object_local(Vector3(0,0,1), PI/2)
		if int(tempPos.z) % 2 != 0:
			tempTrail.rotate_object_local(Vector3(1,0,0), PI/2)
			
		trailDict[tempPos] = tempTrail


func trailPosCalc(CDGP: Vector3, PDP: Vector3):
	var trailPos: Vector3 = PDP
	
	if (CDGP - PDP).x == 2:
		trailPos.x += 1
	if (CDGP - PDP).x == -2:
		trailPos.x += -1
			
	if (CDGP - PDP).y == 2:
		trailPos.y += 1
	if (CDGP - PDP).y == -2:
		trailPos.y += -1
	
	if (CDGP - PDP).z == 2:
		trailPos.z += 1
	if (CDGP - PDP).z == -2:
		trailPos.z += -1
	
	return trailPos


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

