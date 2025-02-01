extends Actor

var health = 50


func _on_hurtbox_area_entered(area: Area2D) -> void:
	$AnimationPlayer.play("hurt")
	await $AnimationPlayer.animation_finished
	queue_free()
