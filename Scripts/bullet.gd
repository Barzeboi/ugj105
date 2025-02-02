extends Area2D

var speed: float = 1500
var damage: int = 50

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
	queue_free()
