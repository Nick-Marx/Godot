extends StaticBody3D


var isTouchOuter: bool = false #trigger for when outer area is colliding
var isTouchInner: bool = false #trigger for when inner area is colliding
var isActive: bool = false #trigger for when dot shares position with player
var pivot_player #will hold player node

# Called when the node enters the scene tree for the first time.
func _ready():
	pivot_player = get_node("/root/pivot_map1/pivot_player")
	if pivot_player.global_position == global_position:
		isActive = true
		
	print(name, "isActive= ", isActive)
	print(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if pivot_player.global_position != global_position:
		isActive = false
	
	if isTouchOuter == true and isActive == false:
		if Input.is_action_just_pressed("action_one"):
			pivot_player.global_position = global_position
			pivot_player.rotate_z(PI)
			pivot_player.change_direction()
			isActive = true
			print(pivot_player.global_position)
			await _on_area_3d_outer_body_exited(pivot_player)


func _on_area_3d_outer_body_entered(body):
	isTouchOuter = true
	print(name, " isTouchOuter= ", isTouchOuter)
	print(body)
	print(name, "isActive= ", isActive)

func _on_area_3d_outer_body_exited(body):
	isTouchOuter = false
	print("isTouchOuter= ", isTouchOuter)

func _on_area_3d_inner_body_entered(body):
	isTouchInner = true

func _on_area_3d_inner_body_exited(body):
	isTouchInner = false
