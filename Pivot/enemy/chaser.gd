extends Node3D


@export var chaserDespawnDistance: int
@export var speedMin: float
@export var speedMax: float
var speed: float

func _ready():
	speed = speedMin
	
	Signals.dotInnerEntered.connect(chaser_movement)


func _physics_process(_delta) -> void:
	$Area3D.rotate_z(speed)


func chaser_movement(dot, area):
	if area.is_in_group("Gchaser") and !Global.isScenePaused:
		if self.global_position == PivotPlayer.global_position:
			return
		
		check_map_rotation()
		update_pos(dot)
		speed_increase()
		respawn()


func check_map_rotation():
	if PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex - 1][0] == PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex][0]:
		self.global_rotation = PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex][1]
		PivotPlayer.playerTrackerIndex += 1


func update_pos(dot: Node3D):
	if dot.global_position == PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex][0]:
		self.rotate_object_local(Vector3(0,0,1), PI)
		self.global_position = dot.global_position
		
		if range(PivotPlayer.playerPathTracker.size() - 1).has(PivotPlayer.playerTrackerIndex):
			if PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex][1] != PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex + 1][1]:
				self.global_rotation = PivotPlayer.playerPathTracker[PivotPlayer.playerTrackerIndex + 1][1]
		
		PivotPlayer.playerTrackerIndex += 1
		speed *= -1


func speed_increase():
	var isCurRotDirNeg: bool = true if speed <0 else false
	var tempNum: float = floorf(clampf(speedMin * (Global.score * (speedMax / speedMin / 500)), speedMin, speedMax) * 100)
	
	speed = tempNum / 100
	if isCurRotDirNeg:
		speed *= -1


func respawn():
	if PivotPlayer.playerPathTracker.size() - PivotPlayer.playerTrackerIndex >= chaserDespawnDistance:
		Global.mainScene.place_chaser()
		self.queue_free()


func _on_area_3d_area_entered(area):
	if area.is_in_group("Gplayer") and !Global.isScenePaused:
		Signals.chaserEntered.emit(self, area)
	
	if area.is_in_group("Gspinner") or area.is_in_group("Gbumper"):
		area.get_parent().queue_free()
		$AudioStreamPlayerDestroy.play()
