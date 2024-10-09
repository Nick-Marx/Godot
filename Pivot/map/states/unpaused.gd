extends State
class_name Unpaused


func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if Global.pivotWheelTimer.is_stopped():
		Global.pivotWheelTimer.start()
	Global.pivotWheelTimer.paused = false
	Global.isScenePaused = false
	Signals.audioChange.emit()

func enter():
	unpause()

func update(delta: float):
	if Input.is_action_just_pressed("pause") or Global.menu.visible == true:
		transitioned.emit(self, "paused")

func exit():
	pass
