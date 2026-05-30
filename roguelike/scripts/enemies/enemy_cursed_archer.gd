extends "res://scripts/enemies/enemy_base.gd"

const ARROW_INTERVAL = 1.8
const ARROW_RANGE = 150.0

var _arrow_timer: float = 0.0

func _ready() -> void:
	max_health = 28
	attack_damage = 0
	move_speed = 50.0
	chase_range = ARROW_RANGE
	attack_range = 22.0
	attack_cooldown = 2.0
	exp_reward = 18
	body_color = Color(0.4, 0.3, 0.1)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		return
	_arrow_timer += delta
	var dist = global_position.distance_to(_player.global_position)
	# Keep distance from player
	if dist < 60.0:
		velocity = -((_player.global_position - global_position).normalized()) * move_speed
		move_and_slide()
	elif dist > ARROW_RANGE:
		velocity = (_player.global_position - global_position).normalized() * move_speed * 0.5
		move_and_slide()
	if _arrow_timer >= ARROW_INTERVAL and dist < ARROW_RANGE:
		_arrow_timer = 0.0
		_shoot_arrow()

func _shoot_arrow() -> void:
	var proj = Node2D.new()
	proj.set_script(load("res://scripts/enemies/projectile.gd"))
	get_parent().add_child(proj)
	proj.global_position = global_position
	var dir = (_player.global_position - global_position).normalized()
	proj.setup(dir, 12, 180.0)
