extends Node3D


@onready var menu: ColorRect = $ColorRect

func _ready() -> void:
	pause()
	Global.menu = menu
	
	$AudioStreamPlayer.play()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if !menu.visible:
			pause()
		else:
			unpause()


func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu.visible = true
	Global.pivotWheelTimer.paused = true
	Global.isScenePaused = true
	
	if $AudioStreamPlayer.stream_paused:
		$AudioStreamPlayer.stream_paused = false
	
	Signals.audioChange.emit()


func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	menu.visible = false
	if Global.pivotWheelTimer.is_stopped():
		Global.pivotWheelTimer.start()
	Global.pivotWheelTimer.paused = false
	Global.isScenePaused = false
	
	if !$AudioStreamPlayer.stream_paused:
		$AudioStreamPlayer.stream_paused = true
	
	Signals.audioChange.emit()

func _on_ng_btn_pressed():
	Global.score = 1
	get_tree().reload_current_scene()
	unpause()


func _on_quit_btn_pressed():
	get_parent().get_tree().quit()


func _on_cont_btn_pressed():
	unpause()
