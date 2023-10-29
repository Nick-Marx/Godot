extends Label

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.menu.visible:
		time += delta
	var seconds = fmod(time,60)
	var minutes = fmod(time, 3600) / 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	text = str_elapsed
