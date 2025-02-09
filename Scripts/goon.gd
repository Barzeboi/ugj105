extends Actor

var health: float = 50
@export var patrol_path: Path2D
@export var state = states.PATROLLING
var bullet = preload("res://Misc/Others/bullet.tscn")
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var player: CharacterBody2D = $"../Player"
@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	add_to_group("Enemies")
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()
		
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if target:
		if (target.x > position.x):
			anim.play("move_right")
		elif (target.x < position.x):
			anim.play("move_left")
		elif (target.y > position.y):
			anim.play("move_down")
		elif (target.y < position.y):
			anim.play("move_up")
		if (target.x - position.x) > (target.y - position.y):
			velocity.y = 0
		elif (target.x - position.x) < (target.y - position.y):
			velocity.x = 0
		if state == states.PATROLLING:
			velocity = position.direction_to(target) * speed
		elif state == states.INVESTIGATE:
			velocity = navigation_agent_2d.get_next_path_position() - global_position
		
	
	move_and_slide()

func _process(delta: float) -> void:
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
			navigation_agent_2d.target_position = target
		states.ENEMY_SPOTTED:
			pass
		states.DEAD:
			speed = 0

func _on_ears_area_entered(area: Area2D) -> void:
	target = area.owner.global_position
	state = states.INVESTIGATE


func _on_sight_area_entered(area: Area2D) -> void:
	if (area.original_position.x - global_position.x) < 50 && (area.original_position.y - global_position.y) > 20:
		target = area.original_position
		state = states.INVESTIGATE
	else:
		get_tree().create_timer(0.2).timout
		target = area.global_position
		state = states.INVESTIGATE
func _on_stop_area_entered(area: Area2D) -> void:
	speed = 0
