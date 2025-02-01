extends Area2D

signal exploded

var damage: int = 2000

func _ready() -> void:
	pass

func _explode():
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(0.1).timeout
	$Explosion/CollisionShape2D.set_deferred("disabled", false)
	
func _on_area_entered(area: Area2D) -> void:
	_explode()
	
	await get_tree().create_timer(0.99).timeout
	queue_free()


func _on_explosion_area_entered(area: Area2D) -> void:
	area._explode()
