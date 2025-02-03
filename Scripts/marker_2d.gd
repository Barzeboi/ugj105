extends Marker2D


func _physics_process(delta: float) -> void:
	$Gun.look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < 0:
		self.position.x = self.position.x * -1
	else:
		pass
