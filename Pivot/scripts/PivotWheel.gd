extends TextureProgressBar


func _ready() -> void:
	Global.pivotWheelTimer = $Timer
	Global.pivotWheel = self

func _on_timer_timeout():
	$".".value += 1 # updates pivot wheel value
