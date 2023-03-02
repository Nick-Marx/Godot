extends Node3D

@onready var pp = $pivot_player #holds pivot_player node

var rand = RandomNumberGenerator.new()
@export var dot: PackedScene #load selectable packed scene
@export var dotRatio:float
var whiteDot:Mesh = load("res://material/white_dot.tres")
var redDot:Mesh = load("res://material/red_dot.tres")
var greenDot:Mesh = load("res://material/green_dot.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	build_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func build_map():
	var tempDot
	var startingColor
	rand.randomize() #ensures the random generation will not repeat every time
	for x in range(-12, 13, 2):#nested for loop to assign grid
		for y in range(-12, 13, 2):
			tempDot = dot.instantiate() #instantiate packed scene as a node
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
			
			
