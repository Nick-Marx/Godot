extends Node3D


@onready var pp = PivotPlayer #holds player *singleton*

#holds scene objects to be instantiated later
@export var dot: PackedScene
@export var bumper: PackedScene
@export var spinner: PackedScene
@export var chaser: PackedScene

#percentage of object placed on board
@export var redDotRatio: float
@export var bumperRatio: float
@export var spinnerRatioMin: float
@export var spinnerRatioMax: float
@export var chaserThreshold: int #score that chaser spawns at
@export var startChaseRange: int #how far away the chaser spawns from the player


#holds dot meshes for mesh swapping
var whiteDot: Mesh = load("res://material/white_dot.tres")
var redDot: Mesh = load("res://material/red_dot.tres")
var greenDot: Mesh = load("res://material/green_dot.tres")

#holds dictionaries to keep track of placed objects
var dotDict: Dictionary = {}
var bumperDict: Dictionary = {}
var spinnerDict: Dictionary = {}

#holds organizer child nodes for this map for debugging
@export var dotOrganizer: Node3D
@export var bumperOrganizer: Node3D
@export var spinnerOrganizer: Node3D
@export var trailOrganizer: Node3D

var isDotPresent: bool = true #indicates if dot is present at current location
#var time = 0 #debug


func _ready() -> void:
	Global.mainScene = self
	Global.trailOrganizer = trailOrganizer
	
	Signals.audioChange.connect(main_audio_control)
	
	$AudioStreamPlayerSlow.play()
	$AudioStreamPlayerSlow.stream_paused = true
	$AudioStreamPlayerFast.play()
	$AudioStreamPlayerFast.stream_paused = true
	
	build_map()
	if dot == null:
		dot = load("res://map/dot.tscn")
	#print("prevDotGlobPos: ", prevDotGlobPos)

func _process(_delta) -> void:
	if !pp.didBuildMap:
		build_map()
		pp.didBuildMap = true
		
	if Global.isSurvivalMode:
		if Global.score >= chaserThreshold:
			place_chaser()
			Global.isSurvivalMode = false
#	time += delta #debug
#	if fmod(floor(time), 10) == 0: #debug
#		print(Detector.global_position.x)
#		print(Detector.global_position.y)
#	if pp.get_child(0).didMove == true:


func main_audio_control():
	if Global.isScenePaused:
		$AudioStreamPlayerSlow.stream_paused = true
		$AudioStreamPlayerFast.stream_paused = true
	if !Global.isScenePaused:
		if pp.speed == pp.hiSpd:
			$AudioStreamPlayerSlow.stream_paused = true
			$AudioStreamPlayerFast.stream_paused = false
		elif pp.speed == pp.loSpd:
			$AudioStreamPlayerFast.stream_paused = true
			$AudioStreamPlayerSlow.stream_paused = false


func build_map():
	for x in range(-10, 11, 2):
		for y in range(-10, 11, 2):
			place_dot(x, y)
	
	for x in range(-10, 11, 1):
		for y in range(-10, 11, 1):
			place_bumper(x, y)
	
	for x in range(-10, 11, 2):
		for y in range(-10, 11, 2):
			place_spinner(x, y)


func place_dot(x, y):
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y)) #picks a position based on current plane
	#print("tempPos: ", tempPos)
		
	if !dotDict.has(tempPos):
		var tempDot = dot.instantiate() #instantiate packed scene as a node
		tempDot.set_name("dot%s" % tempPos)
		dotOrganizer.add_child(tempDot) #adds node to tree as child of organizer node
		tempDot.global_position = tempPos
		if dotDict.has(tempPos):
			return
		else:
			dotDict[tempPos] = tempDot

		if tempDot.global_position == Vector3(0, 0, 0): #starting dot is green
			tempDot.meshNode.set_mesh(greenDot)
		else:
			match Global.rand.randf() > redDotRatio: #percentage of starting dots are red/white
				true:
					tempDot.meshNode.set_mesh(whiteDot)
				false:
					tempDot.meshNode.set_mesh(redDot)


func place_bumper(x, y):
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y)) #picks a position based on current plane
	
	if x in range(-1, 2, 1) and y in range(-1, 2, 1):
		bumperDict[tempPos] = 0
		return
		
	var bumperPlacement = Global.rand.randf() #determines if bumper is placed or not
	
	if (x%2==0 and y%2==0) or (x%2!=0 and y%2!=0):
		return
		
	if !bumperDict.has(tempPos):
		bumperDict[tempPos] = null
		
	if bumperDict[tempPos] == null:
		match bumperPlacement <= bumperRatio:
			true:
				var tempBump = bumper.instantiate() #instantiate packed scene as a node
				tempBump.set_name("bumper%s" % tempPos)
				bumperOrganizer.add_child(tempBump) #adds node to tree as child of organizer node
				tempBump.global_position = tempPos
				tempBump.global_rotation = pp.global_rotation
				
				if x%2!=0 and y%2==0:
					tempBump.rotate_object_local(Vector3(0,0,1), PI/2)
				
				bumperDict[tempPos] = tempBump
			false:
				bumperDict[tempPos] = 0
	

func place_spinner(x, y):
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y)) #picks a position based on current plane
	
	if x in range(-4, 5) and y in range(-4, 5):
		spinnerDict[tempPos] = 0
		return
		
	var spinnerPlacement = Global.rand.randf() #determines if bumper is placed or not
		
	if !spinnerDict.has(tempPos):
		spinnerDict[tempPos] = null
		
	if spinnerDict[tempPos] == null:
		match spinnerPlacement <= snappedf(clampf(spinnerRatioMin * (Global.score * (spinnerRatioMax / spinnerRatioMin / 500)), spinnerRatioMin, spinnerRatioMax), 0.01):
			true:
				var tempSpin = spinner.instantiate() #instantiate packed scene as a node
				tempSpin.set_name("spinner%s" % tempPos)
				spinnerOrganizer.add_child(tempSpin) #adds node to tree as child of organizer node
				tempSpin.global_position = tempPos
				tempSpin.global_rotation = pp.global_rotation
				
				spinnerDict[tempPos] = tempSpin
			false:
				spinnerDict[tempPos] = 0


func place_chaser():
	var tempPosArray: Array = []
	var tempStartPos: Vector3 = Vector3.ZERO
	var tempStartRange: int = 0
	
	for i in range(pp.playerPathTracker.size(), -1, -1):
		if !tempPosArray.has(pp.playerPathTracker[i - 1][0]):
			tempPosArray.append(pp.playerPathTracker[i - 1][0])
			if tempPosArray.size() == startChaseRange + 1:
				tempStartPos = tempPosArray[-1]
				tempStartRange = i - 1
				break
	
	var tempChase = chaser.instantiate() #instantiate packed scene as a node
	self.add_child(tempChase)
	tempChase.global_position = Vector3i(tempStartPos)
	tempChase.global_rotation = pp.playerPathTracker[tempStartRange][1]
	pp.playerTrackerIndex = tempStartRange + 1
