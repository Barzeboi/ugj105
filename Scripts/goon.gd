extends Actor

var health: float = 50
@export var patrol_path: Path2D
@export var state = states.PATROLLING
var bullet = preload("res://Misc/Others/bullet.tscn")
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	add_to_group("Enemies")
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()
		
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if target:
		if target.x > position.x:
			pass
		if state != states.ENEMY_SPOTTED || state != states.DEAD:
			velocity = position.direction_to(target) * speed
		
	
	move_and_slide()

func _process(delta: float) -> void:
	if target:
		if state == states.INVESTIGATE:
			navigation_agent_2d.target_position = target.global_position
	_actions()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	state = states.DEAD
	$AnimationPlayer.play("hurt")
	await $AnimationPlayer.animation_finished
	queue_free()
	
func _actions():
	match state:
		states.IDLE:
			pass
		states.PATROLLING:
			if !patrol_path:
				target = null
				return
			target = patrol_points[current_patrol_point]
			if position.distance_to(target) < 5:
				current_patrol_point = wrapi(current_patrol_point + 1, 0, patrol_points.size())
		states.INVESTIGATE:
			velocity = navigation_agent_2d.get_next_path_position() - global_position
		states.ENEMY_SPOTTED:
			pass
		states.DEAD:
			speed = 0


func _on_ears_area_entered(area: Area2D) -> void:
	target = area
	state = states.INVESTIGATE
