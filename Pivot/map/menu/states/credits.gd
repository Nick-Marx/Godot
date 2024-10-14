extends State
class_name Credits

@export var creditMenu: VBoxContainer


func enter():
	creditMenu.visible = true

func update(_delta: float):
	if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		transitioned.emit(self, "mainmenu")

func exit():
	creditMenu.visible = false
