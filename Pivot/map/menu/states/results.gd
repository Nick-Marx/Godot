extends State
class_name Results

@export var resultsMenu: VBoxContainer

func enter():
	resultsMenu.visible = true

func update(_delta: float):
	if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		transitioned.emit(self, "mainmenu")

func exit():
	resultsMenu.visible = false
