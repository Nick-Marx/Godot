extends Node3D

@onready var meshNode = $Area3D/MeshInstance3D
@export var speed:float = -0.025 #holds rotation speed

func _ready():
	if Global.rand.randf() < 0.5:
		self.speed *= -1

func _process(_delta) -> void:
	self.rotate_object_local(Vector3(0,0,1), speed)


func _on_area_3d_area_entered(area):
	Signals.spinnerEntered.emit(self, area)
	if area.is_in_group("Gplayer") or area.is_in_group("Gspinner") or area.is_in_group("Gbumper"):
		self.speed *= -1
	
	if area.is_in_group("Gplayer") and !Global.isScenePaused:
		$AnimationPlayer.play("bounce")
		$AudioStreamPlayer.play()
	
	if area.is_in_group("Gchaser") and !Global.isScenePaused:
		self.queue_free()
