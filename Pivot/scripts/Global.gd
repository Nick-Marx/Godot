extends Node


var mainScene
var player
var dL3d
var rand = RandomNumberGenerator.new()
var score:int = 1

func _ready():
	rand.randomize() #ensures the randomization is not the exact same each time
