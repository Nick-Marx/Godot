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
	
	credits()


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
	
	if !$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.visible:
		$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.visible = true
		$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainerCredits.visible = false
	
	if !$AudioStreamPlayer.stream_paused:
		$AudioStreamPlayer.stream_paused = true
	
	Signals.audioChange.emit()


func credits():
	if $ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainerCredits.visible:
		if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainerCredits.visible = false
			$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.visible = true

func _on_ng_btn_pressed():
	Global.score = 1
	Global.time = 0
	Global.scoreMultiplyer = 1
	Global.pivotWheel.value = 0
	get_tree().reload_current_scene()
	PivotPlayer.speed = PivotPlayer.loSpd
	if PivotPlayer.global_position != Vector3(0,0,0):
		PivotPlayer.global_position = Vector3(0,0,0)


func _on_quit_btn_pressed():
	get_parent().get_tree().quit()


func _on_cont_btn_pressed():
	unpause()


func _on_cred_btn_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.visible = false
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainerCredits.visible = true
