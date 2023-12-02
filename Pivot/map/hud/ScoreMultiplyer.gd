extends Label


func _process(delta):
	text = "Score Multiplyer: x%s" % clampi(Global.scoreMultiplyer, 1, 5)
