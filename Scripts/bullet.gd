extends Area2D

var speed: float = 1200
var damage: int = 50

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	speed = 0
	$Sprite2D.hide()
	$BulletSound/CollisionShape2D.set_deferred("disabled", false)
