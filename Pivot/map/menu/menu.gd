extends Node3D


@onready var menu: ColorRect = $ColorRect

func _ready() -> void:
	pause()
	Global.menu = menu


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if !menu.visible:
			pause()
		else:
			unpause()


func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu.visible = true


func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	menu.visible = false


func _on_ng_btn_pressed():
	Global.score = 1
	get_tree().reload_current_scene()
	unpause()


func _on_quit_btn_pressed():
	get_parent().get_tree().quit()


func _on_cont_btn_pressed():
	unpause()
