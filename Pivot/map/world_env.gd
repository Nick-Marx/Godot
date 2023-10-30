extends WorldEnvironment


@onready var envProp = self.environment
@export var maxTime: int = 15.0 
var myTimer: float = 5.0 #set to initiate color change quickly on game start
var bgColor: Color
var colorCounter: int

#var bgColorPallete: Dictionary = {
#	0 : Color.WEB_MAROON,
#	1 : Color.CHOCOLATE,
#	2 : Color.DARK_GOLDENROD,
#	3 : Color.SEA_GREEN,
#	4 : Color.CADET_BLUE,
#	5 : Color.REBECCA_PURPLE,
#}

#var bgColorPallete: Dictionary = {
#	0 : Color(.09, 0, 0),
#	1 : Color(.835, .212, 0),
#	2 : Color(.191, .142, .031),
#	3 : Color(.003, .069, 0),
#	4 : Color(0, .016, .073),
#	5 : Color(.063, .003, .099),
#}

var bgColorPallete: Dictionary = {
	0 : Color.hex(0x2b0000ff),
	1 : Color.hex(0x2d1200ff),
	2 : Color.hex(0x2a2d00ff),
	3 : Color.hex(0x052700ff),
	4 : Color.hex(0x001531ff),
	5 : Color.hex(0x1f0237ff),
}

func _ready() -> void:
	colorCounter = Global.rand.randi()%6
#	bgColor = Color.from_ok_hsl(Global.rand.randf(), 1, 0.5, 1)
	bgColor = bgColorPallete[colorCounter]
	envProp.background_color = bgColor
	printt(bgColor, colorCounter)


func _process(delta: float) -> void:
	envProp.background_color = envProp.background_color.lerp(bgColor, 0.003)
	
	myTimer += delta
	if myTimer >= maxTime:
		myTimer = 0.0
		colorCounter += 1
		if colorCounter > 5:
			colorCounter = 0
		bgColor = bgColorPallete[colorCounter]
		printt(bgColor, colorCounter)
#		bgColor = Color.from_ok_hsl(Global.rand.randf(), 1, 0.5, 1)





