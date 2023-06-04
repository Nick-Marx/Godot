extends Node3D


#@onready var ppScript = load("res://player/pivot_player.gd").new() #holds pivot_player script
@onready var pp = PivotPlayer #holds player singleton*
var rand = RandomNumberGenerator.new()
@export var dot:PackedScene #holds dot scene object
@export var dotRatio:float #percentage of red dots generated
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


# Called when the node enters the scene tree for the first time.
func _ready():
	build_map()
	#print("prevDotGlobPos: ", prevDotGlobPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	time += delta #debug
#	if fmod(floor(time), 10) == 0: #debug
#		print(Detector.global_position.x)
#		print(Detector.global_position.y)
	if pp.get_child(0).didMove == true:
#		print(pp.transform)
#		print(dotDict)
#		print("\n", "---", "\n")
		build_map()
		pp.get_child(0).didMove = false


func build_map():
	for x in range(-12, 13, 2):
		for y in range(-12, 13, 2):
			place_dot(x, y)


func place_dot(x, y):
	rand.randomize() #ensures the randomization is not the exact same each time
	
	var tempPos = (Vector3i(pp.global_position) + Vector3i(pp.transform.basis.x * x) + Vector3i(pp.transform.basis.y * y))
#	print("tempPos: ", tempPos)
	if dot == null:
		dot = load("res://map/dot.tscn")
		
	if !dotDict.has(tempPos):
		tempDot = dot.instantiate() #instantiate packed scene as a node
		tempDot.set_script(load("res://map/dot.gd"))
		tempDot.set_name("dot%s" % tempPos)
		add_child(tempDot) #adds node to tree as child of this script owner
		tempDot.global_position = tempPos
		if dotDict.has(tempPos):
			return
		else:
			dotDict[tempPos] = tempDot

		if tempDot.global_position == Vector3(0, 0, 0): #starting dot is green
			tempDot.get_child(2).set_mesh(greenDot)
		else:
			startingColor = rand.randf() #percentage of starting dots are red/white
			match startingColor > dotRatio:
				true:
					tempDot.get_child(2).set_mesh(whiteDot)
				false:
					tempDot.get_child(2).set_mesh(redDot)

	
	
	
