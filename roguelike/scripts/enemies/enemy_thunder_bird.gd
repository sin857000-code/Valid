extends "res://scripts/enemies/enemy_base.gd"

var _shoot_timer = 0.0

func _ready() -> void:
	max_health = 50
	attack_damage = 13
	move_speed = 95.0
	chase_range = 240.0
	attack_range = 180.0
	attack_cooldown = 1.6
	exp_reward = 36
	body_color = Color(0.3, 0.5, 0.9)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_shoot_timer -= delta
	if _shoot_timer <= 0.0:
		_shoot_timer = attack_cooldown
		_fire_lightning_spread()

func _fire_lightning_spread() -> void:
	if _player == null:
		return
	var base_dir = (_player.global_position - global_position).normalized()
	var spread_angles = [-0.2, 0.2]
	for angle_offset in spread_angles:
		var dir = base_dir.rotated(angle_offset)
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		proj.setup(dir, attack_damage, 250.0)
