extends Node3D


@export var speed:float = -0.025 #holds rotation speed

func _ready():
	if Global.rand.randf() < 0.5:
		self.speed *= -1

func _process(delta):
	self.rotate_object_local(Vector3(0,0,1), speed)


func _on_area_3d_area_entered(area):
	Signals.spinnerEntered.emit(self, area)
	if area.is_in_group("Gplayer") or area.is_in_group("Gspinner") or area.is_in_group("Gbumper"):
		self.speed *= -1

