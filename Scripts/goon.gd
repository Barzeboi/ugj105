extends Actor

var health = 50

enum {
	IDLE,
	PATROLLING,
	ENEMY_SPOTTED,
	DEAD
}

func _ready() -> void:
	add_to_group("Enemies")

func _on_hurtbox_area_entered(area: Area2D) -> void:
	$AnimationPlayer.play("hurt")
	await $AnimationPlayer.animation_finished
	queue_free()
