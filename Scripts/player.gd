extends Actor

@onready var bullet = preload("res://Misc/Others/bullet.tscn")
var bullets_left: int = 2

func get_input():
	var input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		_shoot()
	
func _shoot():
	if bullets_left > 0:
		var b = bullet.instantiate()
		owner.add_child(b)
		b.transform = $Marker2D/Gun/Marker2D.global_transform
		b.original_position = $Marker2D/Gun/Marker2D.global_position
		bullets_left -= 1
