extends Node3D


#@onready var ppScript = load("res://player/pivot_player.gd").new() #holds pivot_player script
@onready var pp = PivotPlayer #holds player singleton*
var rand = RandomNumberGenerator.new()
@export var dot:PackedScene #holds dot scene object
@onready var dotScript = load("res://map/dot.gd")
@export var bumper:PackedScene #holds bumper scene object
@export var dotRatio:float #percentage of red dots generated
@export var bumperRatio:float #percentage of bumpers on the board
var whiteDot:Mesh = load("res://material/white_dot.tres")
var redDot:Mesh = load("res://material/red_dot.tres")
var greenDot:Mesh = load("res://material/green_dot.tres")
var tempDot #holds temporary dot node until it's instantiated
var startingColor #used to set instantiated dot color
var isDotPresent:bool = true #indicates if dot is present at current location
#@onready var prevDotGlobPos:Vector3 = PivotPlayer.global_position
#@onready var prevDotGlobPos:Transform3D = PivotPlayer.global_transform
#var time = 0 #debug
var dotDict = {}
var bumperDict = {}
var spinnerDict = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.mainScene = self
	build_map()
	if dot == null:
		dot = load("res://map/dot.tscn")
	
	rand.randomize() #ensures the randomization is not the exact same each time
	#print("prevDotGlobPos: ", prevDotGlobPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	time += delta #debug
#	if fmod(floor(time), 10) == 0: #debug
#		print(Detector.global_position.x)
#		print(Detector.global_position.y)
#	if pp.get_child(0).didMove == true:
	if pp.didBuildMap == false:
#		print(pp.transform)
#		print(dotDict)
#		print(bumperDict)
#		print("\n", "---", "\n")
		build_map()
#		pp.get_child(0).didMove = false
		pp.didBuildMap = true


func build_map():
	for x in range(-10, 11, 2):
		for y in range(-10, 11, 2):
			place_dot(x, y)
	
	for x in range(-10, 11, 1):
		for y in range(-10, 11, 1):
			place_bumper(x, y)


func place_dot(x, y):
#	rand.randomize() #ensures the randomization is not the exact same each time
	
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y)) #picks a position based on current plane
	#print("tempPos: ", tempPos)
	
		
	if !dotDict.has(tempPos):
		tempDot = dot.instantiate() #instantiate packed scene as a node
#		tempDot.set_script(dotScript)
		tempDot.set_name("dot%s" % tempPos)
		add_child(tempDot) #adds node to tree as child of this script owner
		tempDot.global_position = tempPos
		if dotDict.has(tempPos):
			return
		else:
			dotDict[tempPos] = tempDot

		if tempDot.global_position == Vector3(0, 0, 0): #starting dot is green
			tempDot.meshNode.set_mesh(greenDot)
		else:
			startingColor = rand.randf() #percentage of starting dots are red/white
			match startingColor > dotRatio:
				true:
					tempDot.meshNode.set_mesh(whiteDot)
				false:
					tempDot.meshNode.set_mesh(redDot)


func place_bumper(x, y):
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y)) #picks a position based on current plane
	
	if x in range(-1, 2, 1) and y in range(-1, 2, 1):
		bumperDict[tempPos] = 0
		return
		
	var bumperPlacement = rand.randf() #determines if bumper is placed or not
	
	if (x%2==0 and y%2==0) or (x%2!=0 and y%2!=0):
		return
		
	if !bumperDict.has(tempPos):
		bumperDict[tempPos] = null
		
	if bumperDict[tempPos] == null:
		match bumperPlacement <= bumperRatio:
			true:
				var tempBump = bumper.instantiate() #instantiate packed scene as a node
				tempBump.set_script(load("res://enemy/bumper.gd"))
				tempBump.set_name("bumper%s" % tempPos)
				add_child(tempBump) #adds node to tree as child of this script owner
				tempBump.global_position = tempPos
				tempBump.global_rotation = pp.global_rotation
				
				if x%2!=0 and y%2==0:
					tempBump.rotate_object_local(Vector3(0,0,1), PI/2)
				
				bumperDict[tempPos] = tempBump
			false:
				bumperDict[tempPos] = 0
	


