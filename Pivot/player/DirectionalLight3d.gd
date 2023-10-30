extends DirectionalLight3D


@onready var pp = PivotPlayer


func _ready():
	Global.dL3d = self


func _on_area_3d_area_entered(area):
	if area.visible:
		area.visible = false


func _on_area_3d_area_exited(area):
	if !area.visible:
		area.visible = true


