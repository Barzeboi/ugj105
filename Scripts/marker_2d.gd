extends Marker2D


func _physics_process(delta: float) -> void:
	$Gun.look_at(get_global_mouse_position())
