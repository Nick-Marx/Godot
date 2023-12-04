extends Label


func _process(_delta) -> void:
	text = "Score: %s" % Global.score
