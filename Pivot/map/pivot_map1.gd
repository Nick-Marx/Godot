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
#@export var dotDetector:PackedScene #holds area3d that's used to determine if a dot is at a location
var dotDetector = Detector #holds area3d that's used to determine if a dot is at a location (autoload)
var isDotPresent:bool = true #indicates if dot is present at current location
@onready var prevDotGlobPos:Vector3 = PivotPlayer.global_position
#var time = 0 #debug

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

func place_dot(x, y):
	rand.randomize() #ensures the random generation will not repeat every time
	if dot == null:
		dot = load("res://map/dot_0.tscn")
		
	tempDot = dot.instantiate() #instantiate packed scene as a node
	tempDot.set_script(load("res://map/dot_0.gd"))
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

func search_for_dot(x, y): #searches for dot at location
#	if dotDetector == null: #not needed with autoload
#		dotDetector = load("res://map/Detector.tscn")
	Detector.global_position = Vector3(x,y,0)
	print("Detector: ", Detector.global_position)
	if Detector.isColliding == true:
		isDotPresent = true
		print("is Colliding")

func search_and_place_dot(x, y):
	search_for_dot(x, y)
	if isDotPresent == false:
		place_dot(x, y)
	isDotPresent = false
	Detector.isColliding = false
	
	
	
	
	
