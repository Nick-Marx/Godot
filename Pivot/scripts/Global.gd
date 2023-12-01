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
var trailOrganizer: Node3D

var debug_isFullScreen: bool = false

func _ready():
	rand.randomize() #ensures the randomization is not the exact same each time
	

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_page_up") and !debug_isFullScreen:
		DisplayServer.window_set_mode(3)
		debug_isFullScreen = true
