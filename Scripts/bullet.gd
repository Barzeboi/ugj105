extends Area2D

signal noise

var speed: float = 1200
var damage: int = 50
@onready var hit_mark = preload("res://Misc/Others/hit_mark.tscn")
var original_position

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	speed = 0
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$BulletSound/CollisionShape2D.set_deferred("disabled", false)
	await get_tree().create_timer(0.1).timeout
	$BulletSound/CollisionShape2D.set_deferred("disabled", true)
