extends Node

var enemies
var level_completed: bool

@onready var player: CharacterBody2D = get_node("/root/TestLevel/Player")


func _process(delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("Enemies")

	if player.bullets_left == 0 and enemies > 0:
		level_completed = false
