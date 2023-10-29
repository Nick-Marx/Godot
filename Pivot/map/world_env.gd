extends WorldEnvironment


@onready var envProp = self.environment
@export var maxTime: int = 10.0 
var myTimer: float = 5.0 #set to initiate color change quickly on game start
var bgColor

var bgColorPallete: Dictionary = {
	0 : Color.WEB_MAROON,
	1 : Color.CADET_BLUE,
	2 : Color.OLIVE,
	3 : Color.SIENNA,
	4 : Color.SEA_GREEN,
	5 : Color.REBECCA_PURPLE,
}

func _ready() -> void:
#	bgColor = Color.from_ok_hsl(Global.rand.randf(), 1, 0.5, 1)
	bgColor = bgColorPallete[Global.rand.randi()%6]
	envProp.background_color = bgColor


func _process(delta: float) -> void:
	envProp.background_color = envProp.background_color.lerp(bgColor, 0.003)
	
	myTimer += delta
	if myTimer >= maxTime:
		myTimer = 0.0
		bgColor = bgColorPallete[Global.rand.randi()%6]
#		bgColor = Color.from_ok_hsl(Global.rand.randf(), 1, 0.5, 1)





