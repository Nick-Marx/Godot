extends State
class_name MainMenu

@export var mainMenu: VBoxContainer
@export var rootMenu: CenterContainer

func _ready() -> void:
	Global.menu = rootMenu
	Signals.chaserEntered.connect(game_over)

func enter():
	mainMenu.visible = true


func exit():
	mainMenu.visible = false

func _on_ng_btn_pressed():
	Global.lastEndScore = Global.score
	Global.lastEndTime = Global.timeElapsed
	Global.totalScore += Global.score if Global.score > 1 else 0
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
	Global.menu.visible = false

func _on_cred_btn_pressed():
	transitioned.emit(self, "credits")

func _on_how_to_btn_pressed():
	transitioned.emit(self, "howto")

func _on_result_btn_pressed():
	transitioned.emit(self, "results")

func _on_optn_btn_pressed():
	transitioned.emit(self, "options")

func game_over(_chaser, _player):
	_on_ngs_btn_pressed()
	Global.menu.visible = true
	_on_result_btn_pressed()
