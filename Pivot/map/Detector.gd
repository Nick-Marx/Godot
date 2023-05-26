extends Area3D

var isColliding:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_detector_body_entered(body):
	isColliding = true
	print("entered: ", body, " [", self.global_position,"]")


func _on_detector_body_exited(body):
	isColliding = false
	print("exited: ", body, "\n")
