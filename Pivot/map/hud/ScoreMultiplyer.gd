extends Label


func _process(_delta) -> void:
	text = "Multiplier: x%s" % clampi(Global.scoreMultiplyer, 1, 5)
