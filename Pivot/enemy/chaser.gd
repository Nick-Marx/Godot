extends Node3D


@export var speed: float

func _ready():
	Signals.dotInnerEntered.connect(chaser_movement)


func _physics_process(_delta) -> void:
	rotate_z(speed)


func chaser_movement(dot, area):
	if area.is_in_group("Gchaser") and !Global.isScenePaused:
		printt(dot.global_position, "looking for ", PivotPlayer.playerPathTracker[Global.mainScene.playerTrackerIndex])
		if self.global_position == PivotPlayer.global_position:
			return
			
		if dot.global_position == PivotPlayer.playerPathTracker[Global.mainScene.playerTrackerIndex]:
			#self.rotate_z(PI)
			#self.scale = Vector3(1, 1, -1)
			self.rotate_object_local(Vector3(0,0,1), PI)
			self.global_position = dot.global_position
			self.global_rotation = PivotPlayer.playerRotationTracker[Global.mainScene.playerTrackerIndex]
			speed *= -1
			
			printt( PivotPlayer.playerPathTracker[Global.mainScene.playerTrackerIndex], PivotPlayer.playerRotationTracker[Global.mainScene.playerTrackerIndex])
			printt("chaser rotation ", self.global_rotation )
			
			
			Global.mainScene.playerTrackerIndex += 1
			
			


func _on_area_3d_area_entered(area):
	if area.is_in_group("Gplayer") and !Global.isScenePaused:
		Signals.chaserEntered.emit(self, area)
	
	if area.is_in_group("Gspinner"):
		speed *= -1
