extends Label


func _process(_delta) -> void:
	text = "Score Multiplyer: x%s" % clampi(Global.scoreMultiplyer, 1, 5)
