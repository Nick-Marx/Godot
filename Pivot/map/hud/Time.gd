extends Label


var seconds: float
var minutes: float
var hours: float


func _ready():
	Global.time = 0


func _process(delta):
	if !Global.menu.visible:
		Global.time += delta
	time()
	text = Global.timeElapsed


func time():
	seconds = fmod(Global.time, 60)
	minutes = fmod(Global.time, 3600) / 60
	hours = fmod(Global.time, 86400) / 3600
	Global.timeElapsed = "%02d : %02d : %02d" % [hours, minutes, seconds]
