extends Area2D



func _on_area_entered(area: Area2D) -> void:
	$AnimatedSprite2D.play("default")
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
