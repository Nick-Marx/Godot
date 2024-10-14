extends State
class_name HowTo

@export var howToMenu: VBoxContainer

func enter():
	howToMenu.visible = true

func update(_delta: float):
	if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		transitioned.emit(self, "mainmenu")

func exit():
	howToMenu.visible = false
