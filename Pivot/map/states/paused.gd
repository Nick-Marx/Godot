extends State
class_name Paused


func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.menu.visible = true
	Global.pivotWheelTimer.paused = true
	Global.isScenePaused = true
	Signals.audioChange.emit()

func enter():
	pause()

func update(_delta: float):
	if Input.is_action_just_pressed("pause"):
		pass
	if Global.menu.visible == false:
		transitioned.emit(self, "unpaused")

func exit():
	pass
