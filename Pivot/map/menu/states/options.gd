extends State
class_name Options

@export var optionMenu: VBoxContainer

var musicBusIndex: int
var sfxBusIndex: int


func _ready():
	musicBusIndex = AudioServer.get_bus_index("Music")
	sfxBusIndex = AudioServer.get_bus_index("SFX")


func enter():
	optionMenu.visible = true

func update(delta: float):
	if Input.is_action_pressed("action_one") or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		transitioned.emit(self, "mainmenu")

func exit():
	optionMenu.visible = false

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
