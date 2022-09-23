extends StaticBody

class_name dot

#indicate if dot is current pivot position
var isTouching = false
var isActive = false
var pivotPlayerScript
#fn for moving player and regulating rotation speed

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pivotPlayerScript = get_node("/root/map_1/pivot_player")
	if pivotPlayerScript.global_translation == global_translation:
		isActive = true
		print(isActive)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OuterCollisionArea_body_entered(body):
	isTouching = true
	print("isTouching: ", isTouching)
	var location = global_translation
	print(location)
	print(isActive)
	if (Input.is_action_pressed("action_one") and isActive == false) or (Input.is_action_just_pressed("action_one") and isActive == false):
		body.get_parent().move_pivot_player(location)
		isActive = true
		
func _on_OuterCollisionArea_body_exited(body):
	isTouching = false
	print("isTouching: ", isTouching)
	if pivotPlayerScript.global_translation != global_translation:
		isActive = false
		print(isActive)
