extends "res://scripts/enemies/enemy_base.gd"

var _shoot_timer = 0.0
const FLEE_RANGE = 80.0

func _ready() -> void:
	max_health = 45
	attack_damage = 14
	move_speed = 65.0
	chase_range = 220.0
	attack_range = 200.0
	attack_cooldown = 1.8
	exp_reward = 35
	body_color = Color(0.5, 0.2, 0.7)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		super._physics_process(delta)
		return

	_shoot_timer -= delta
	if _shoot_timer <= 0.0:
		_shoot_timer = attack_cooldown
		_fire_arrow()

	var dist = global_position.distance_to(_player.global_position)
	if dist < FLEE_RANGE:
		var flee_dir = (global_position - _player.global_position).normalized()
		velocity = flee_dir * move_speed
		move_and_slide()
	else:
		super._physics_process(delta)

func _fire_arrow() -> void:
	if _player == null:
		return
	var dir = (_player.global_position - global_position).normalized()
	var proj = Node2D.new()
	proj.set_script(load("res://scripts/enemies/projectile.gd"))
	get_parent().add_child(proj)
	proj.global_position = global_position
	proj.setup(dir, attack_damage, 220.0)
