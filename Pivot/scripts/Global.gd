extends Node


var mainScene: Node3D
var menu: ColorRect
var pivotWheelTimer: Timer
var pivotWheel: TextureProgressBar
var player: Node3D
var dL3d: DirectionalLight3D
var rand = RandomNumberGenerator.new()
var score: int = 1
var isScenePaused: bool

func _ready():
	rand.randomize() #ensures the randomization is not the exact same each time
	
