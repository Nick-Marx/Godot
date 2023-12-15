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


func _ready():
	rand.randomize() #ensures the randomization is not the exact same each time
	
