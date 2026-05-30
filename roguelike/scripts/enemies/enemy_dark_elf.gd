extends "res://scripts/enemies/enemy_base.gd"

var _shoot_timer = 0.0
const KITE_RANGE = 100.0
const PREFERRED_RANGE = 160.0

func _ready() -> void:
	max_health = 40
	attack_damage = 11
	move_speed = 75.0
	chase_range = 250.0
	attack_range = 200.0
	attack_cooldown = 1.5
	exp_reward = 32
	body_color = Color(0.2, 0.15, 0.3)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		super._physics_process(delta)
		return

	_shoot_timer -= delta
	if _shoot_timer <= 0.0:
		_shoot_timer = attack_cooldown
		_fire_triple_arrow()

	var dist = global_position.distance_to(_player.global_position)
	if dist < KITE_RANGE:
		var flee_dir = (global_position - _player.global_position).normalized()
		velocity = flee_dir * move_speed
		move_and_slide()
	elif dist < PREFERRED_RANGE:
		velocity = velocity.lerp(Vector2.ZERO, 0.15)
		move_and_slide()
	else:
		super._physics_process(delta)

func _fire_triple_arrow() -> void:
	if _player == null:
		return
	var base_dir = (_player.global_position - global_position).normalized()
	var spread_angles = [-0.25, 0.0, 0.25]
	for angle_offset in spread_angles:
		var dir = base_dir.rotated(angle_offset)
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		proj.setup(dir, attack_damage, 200.0)
