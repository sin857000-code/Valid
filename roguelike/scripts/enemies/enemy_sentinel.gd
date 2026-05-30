extends "res://scripts/enemies/enemy_base.gd"

const SENTINEL_RANGE = 120.0

func _ready() -> void:
	max_health = 45
	attack_damage = 14
	move_speed = 0.0
	chase_range = SENTINEL_RANGE
	attack_range = SENTINEL_RANGE
	attack_cooldown = 1.5
	exp_reward = 22
	body_color = Color(0.5, 0.5, 0.7)
	body_size = 15
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		_attack_timer -= delta
		return
	_attack_timer -= delta
	# Sentinel doesn't move, just shoots
	var dist = global_position.distance_to(_player.global_position)
	if dist < SENTINEL_RANGE and _attack_timer <= 0.0:
		_attack_timer = attack_cooldown
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		var dir = (_player.global_position - global_position).normalized()
		proj.setup(dir, attack_damage, 160.0)
