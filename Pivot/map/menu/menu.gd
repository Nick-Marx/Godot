extends CenterContainer


@export var mainMenu: VBoxContainer
@export var creditMenu: VBoxContainer
@export var howToMenu: VBoxContainer
@export var resultsMenu: VBoxContainer
@export var optionMenu: VBoxContainer

@export var menuMusic: AudioStreamPlayer


var musicBusIndex: int
var sfxBusIndex: int


func _ready() -> void:
	pause()
	Global.menu = self
	
	Signals.chaserEntered.connect(game_over)
	
	musicBusIndex = AudioServer.get_bus_index("Music")
	sfxBusIndex = AudioServer.get_bus_index("SFX")
	
	menuMusic.play()


func _process(_delta) -> void:
	if Input.is_action_just_pressed("pause"):
		if !self.visible:
			pause()
		else:
			unpause()
	
	credits()
	how_to_play()
	results()
	options()


func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.visible = true
	Global.pivotWheelTimer.paused = true
	Global.isScenePaused = true
	
	if menuMusic.stream_paused:
		menuMusic.stream_paused = false
	
	Signals.audioChange.emit()


func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.visible = false
	if Global.pivotWheelTimer.is_stopped():
		Global.pivotWheelTimer.start()
	Global.pivotWheelTimer.paused = false
	Global.isScenePaused = false
	
	if !mainMenu.visible:
		mainMenu.visible = true
		creditMenu.visible = false
		howToMenu.visible = false
		resultsMenu.visible = false
		optionMenu.visible = false
	
	if !menuMusic.stream_paused:
		menuMusic.stream_paused = true
	
	Signals.audioChange.emit()


func game_over(chaser, player):
	_on_ngs_btn_pressed()
	pause()
	_on_result_btn_pressed()


func how_to_play():
	if howToMenu.visible:
		if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			howToMenu.visible = false
			mainMenu.visible = true


func credits():
	if creditMenu.visible:
		if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			creditMenu.visible = false
			mainMenu.visible = true


func results():
	if resultsMenu.visible:
		if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			resultsMenu.visible = false
			mainMenu.visible = true


func options():
	if optionMenu.visible:
		if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			optionMenu.visible = false
			mainMenu.visible = true


func _on_ng_btn_pressed():
	Global.lastEndScore = Global.score
	Global.lastEndTime = Global.timeElapsed
	Global.totalScore += Global.score
	Global.totalTime += Global.time
	Signals.newGame.emit()
	
	Global.score = 1
	Global.time = 0
	Global.scoreMultiplyer = 1
	Global.pivotWheel.value = 0
	PivotPlayer.speed = PivotPlayer.loSpd
	get_tree().reload_current_scene()
	Global.isSurvivalMode = false
	
	
	if PivotPlayer.global_position != Vector3(0,0,0):
		PivotPlayer.global_position = Vector3(0,0,0)


func _on_ngs_btn_pressed():
	_on_ng_btn_pressed()
	Global.isSurvivalMode = true


func _on_quit_btn_pressed():
	get_parent().get_tree().quit()


func _on_cont_btn_pressed():
	unpause()


func _on_cred_btn_pressed():
	mainMenu.visible = false
	creditMenu.visible = true


func _on_how_to_btn_pressed():
	mainMenu.visible = false
	howToMenu.visible = true


func _on_result_btn_pressed():
	mainMenu.visible = false
	resultsMenu.visible = true


func _on_optn_btn_pressed():
	mainMenu.visible = false
	optionMenu.visible = true


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBusIndex, linear_to_db(value))


func _on_ful_scrn_btn_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(3)
	if !toggled_on:
		DisplayServer.window_set_mode(0)


func _on_ui_res_btn_item_selected(index):
	if index == 0:
		get_tree().root.content_scale_factor = 1
	if index == 1:
		get_tree().root.content_scale_factor = 1.2
	if index == 2:
		get_tree().root.content_scale_factor = 1.5
