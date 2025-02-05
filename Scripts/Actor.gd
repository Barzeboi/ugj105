extends CharacterBody2D

class_name Actor

var speed: float = 90
var patrol_position = 120
var target = null
var player = null
var current_patrol_point = 0
var patrol_points = []

enum states {
	IDLE,
	PATROLLING,
	SUSPICIOUS,
	ENEMY_SPOTTED,
	DEAD
}
