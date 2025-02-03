extends CharacterBody2D

class_name Actor

var speed: float = 90
var patrol_position = 120

enum {
	IDLE,
	PATROLLING,
	SUSPICIOUS,
	ENEMY_SPOTTED,
	NERVOUS,
	DEAD
}

var state = IDLE
