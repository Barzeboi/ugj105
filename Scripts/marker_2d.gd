extends Marker2D

var original_position

func _physics_process(delta: float) -> void:
	$Gun.look_at(get_global_mouse_position())
	
	if (get_global_mouse_position().x - global_position.x) <= 0:
		original_position = global_position.x
		global_position.x = global_position.x * -1
	#else:
		#global_position.x = original_position
