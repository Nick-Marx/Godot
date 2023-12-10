extends Node


var mainScene: Node3D
var menu: CenterContainer
var pivotWheelTimer: Timer
var pivotWheel: TextureProgressBar
var player: Node3D
var dL3d: DirectionalLight3D
var rand = RandomNumberGenerator.new()
var score: int = 1
var isScenePaused: bool
var trailOrganizer: Node3D
var time: float
var scoreMultiplyer: int = 1
var isSurvivalMode: bool = false
var timeElapsed: String

var lastEndScore: int
var lastEndTime: String
var totalScore: int
var totalTime: float

#debugging
var debug_isFullScreen: bool = false

func _ready():
	rand.randomize() #ensures the randomization is not the exact same each time
	

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_page_up") and !debug_isFullScreen:
		DisplayServer.window_set_mode(3)
		debug_isFullScreen = true
	elif Input.is_action_pressed("ui_page_up") and debug_isFullScreen:
		DisplayServer.window_set_mode(0)
		debug_isFullScreen = false
