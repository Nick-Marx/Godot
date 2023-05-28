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
@onready var prevDotGlobPos:Vector3 = PivotPlayer.global_position
#var time = 0 #debug
var dotArray = []

@export var dotDetector:PackedScene #holds area3d that's used to determine if a dot is at a location
var detector

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
	if pp.didMove == true:
		expand_map()
		pp.didMove = false

func build_map():
	for x in range(pp.global_position.x - 12, pp.global_position.x + 13, 2):#nested for loop to assign grid
		for y in range(pp.global_position.y - 12, pp.global_position.y + 13, 2):
			place_dot(x, y)

func expand_map():#generates map as player moves
	if pp.global_position.x - prevDotGlobPos.x == 2:
		var x = pp.global_position.x + 12
		for y in range(pp.global_position.y - 12, pp.global_position.y + 13, 2):
			search_and_place_dot(x, y)
			#print(x, ",", y)
		prevDotGlobPos = pp.global_position
	
	if pp.global_position.x - prevDotGlobPos.x == -2:
		var x = pp.global_position.x - 12
		for y in range(pp.global_position.y - 12, pp.global_position.y + 13, 2):
			search_and_place_dot(x, y) 
			#print(x, ",", y)
		prevDotGlobPos = pp.global_position
		
	if pp.global_position.y - prevDotGlobPos.y == 2:
		var y = pp.global_position.y + 12
		for x in range(pp.global_position.x - 12, pp.global_position.x + 13, 2):
			search_and_place_dot(x, y)
			#print(x, ",", y)
		prevDotGlobPos = pp.global_position
		
	if pp.global_position.y - prevDotGlobPos.y == -2:
		var y = pp.global_position.y - 12
		for x in range(pp.global_position.x - 12, pp.global_position.x + 13, 2):
			search_and_place_dot(x, y) 
			#print(x, ",", y)
		prevDotGlobPos = pp.global_position

func place_dot(x, y, z = 0):
	rand.randomize() #ensures the randomization is not the exact same each time
	if dot == null:
		dot = load("res://map/dot.tscn")
		
	tempDot = dot.instantiate() #instantiate packed scene as a node
	tempDot.set_script(load("res://map/dot.gd"))
	tempDot.set_name("dot_%d_%d_%d" % [x, y, z])
	dotArray.append(tempDot.name)
	add_child(tempDot) #adds node to tree as child of this script owner
	tempDot.global_position = Vector3(x, y, 0) #sets node position
	if tempDot.global_position == Vector3(0, 0, 0): #starting dot is green
		tempDot.get_child(2).set_mesh(greenDot)
	else:
		startingColor = rand.randf() #percentage of starting dots are red/white
		match startingColor > dotRatio:
			true:
				tempDot.get_child(2).set_mesh(whiteDot)
			false:
				tempDot.get_child(2).set_mesh(redDot)

func search_for_dot(x, y, z = 0): #searches for dot at location
#	if dotDetector == null: #not needed with autoload
#		dotDetector = load("res://map/Detector.tscn")
#	Detector.global_position = Vector3(x,y,0)
#	print("Detector: ", Detector.global_position)
#	if Detector.isColliding == true:
#		isDotPresent = true
#		print("is Colliding")
	
#	for i in dotArray:
#		if i == "dot_%d_%d_%d" % [x, y, z]:
#			isDotPresent = true
#			print(i)
#			return
#		else:
#			isDotPresent = false
#			#print(i + " false")

	if dotDetector == null:
		dotDetector = load("res://map/Detector.tscn")
		
	detector = dotDetector.instantiate() #instantiate packed scene as a node
	detector.set_script(load("res://map/Detector.gd"))
	#detector.connect("Collided", self, "")
	add_child(detector) #adds node to tree as child of this script owner
	detector.global_position = Vector3(x, y, z) #sets node position
	
	
	
	print(detector.get_overlapping_bodies())
	print(detector.global_position)
#	if detector.get_overlapping_bodies().has("dot_%d_%d_%d" % [x, y, z]):
#		print("dot_%d_%d_%d" % [x, y, z])
	
	if detector.isColliding == true:
		isDotPresent = true


func search_and_place_dot(x, y, z = 0):
	search_for_dot(x, y)
	if isDotPresent == false:
		place_dot(x, y)
	detector.queue_free()
	isDotPresent = false
	#Detector.global_position = Vector3(1,0,0)
	#print("Detector: ", Detector.global_position, Detector.currentOverlappingBody, Detector.currentOverlappingBody.global_position)
#	Detector.isColliding = false
	
	
	
	
	
