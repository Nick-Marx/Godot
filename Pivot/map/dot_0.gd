extends StaticBody3D


class_name dot_0
var isTouchOuter: bool = false #trigger for when outer area is colliding
var isTouchInner: bool = false #trigger for when inner area is colliding
var isActive: bool = false #trigger for when dot shares position with player
var pp #will hold player node



#moves player to new dot if player uses action only in outer trigger zone
func outer_area_player_action():
	if Input.is_action_pressed("action_one"):
		pp.global_position = global_position
		pp.rotate_z(PI)
		if (pp.speed < -0.02) or (pp.speed > 0.02):
			pp.speed /= pp.spdCtrl * pp.rotDir
		else:
			pp.speed *= pp.rotDir #sets player speed to low and changes direction
		isActive = true
		print(pp.global_position)
		await _on_area_3d_outer_body_exited(pp)
		
#moves player to new dot if player uses action in inner trigger area and speeds rotation
func inner_area_player_action():
	if Input.is_action_just_pressed("action_one"):
		pp.global_position = global_position
		pp.rotate_z(PI)
		if (pp.speed > -0.05) and (pp.speed < 0.05):
			pp.speed *= pp.spdCtrl * pp.rotDir
		else:
			pp.speed *= pp.rotDir #sets player speed to low and changes direction
		isActive = true
		print(pp.global_position)
		await _on_area_3d_inner_body_exited(pp)

# Called when the node enters the scene tree for the first time.
func _ready():
	pp = get_node("/root/pivot_map1/pivot_player")
	print(name, "isActive= ", isActive)
	print(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if pp.global_position == global_position:
		isActive = true
	else:
		isActive = false
	
	if isTouchInner == true and isActive == false:
		inner_area_player_action()
	elif isTouchOuter == true and isTouchInner != true and isActive == false:
		outer_area_player_action()


func _on_area_3d_outer_body_entered(body):
	if body == pp:
		isTouchOuter = true
	print(name, " isTouchOuter= ", isTouchOuter)
	print(body)
	print(name, "isActive= ", isActive)

func _on_area_3d_outer_body_exited(body):
	if body == pp:
		isTouchOuter = false
	print("isTouchOuter= ", isTouchOuter)

func _on_area_3d_inner_body_entered(body):
	if body == pp:
		isTouchInner = true

func _on_area_3d_inner_body_exited(body):
	if body == pp:
		isTouchInner = false
