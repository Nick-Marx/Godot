extends Node3D

@onready var meshNode = $Area3D/MeshInstance3D

func _on_area_3d_area_entered(area):
	Signals.bumperEntered.emit(self, area)
	if area.is_in_group("Gplayer") and !Global.isScenePaused:
		$AudioStreamPlayer.play()
