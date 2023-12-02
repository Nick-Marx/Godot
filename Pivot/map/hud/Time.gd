extends Label


func _ready():
	Global.time = 0


func _process(delta):
	if !Global.menu.visible:
		Global.time += delta
	var seconds = fmod(Global.time,60)
	var minutes = fmod(Global.time, 3600) / 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	text = str_elapsed
