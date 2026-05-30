extends "res://scripts/enemies/enemy_base.gd"

const PLAGUE_INTERVAL = 3.5
const PLAGUE_RANGE = 100.0

var _plague_timer: float = 0.0

func _ready() -> void:
	max_health = 32
	attack_damage = 8
	move_speed = 48.0
	chase_range = 220.0
	attack_range = 22.0
	attack_cooldown = 1.5
	exp_reward = 20
	body_color = Color(0.5, 0.7, 0.3)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_plague_timer += delta
	if _plague_timer >= PLAGUE_INTERVAL:
		_plague_timer = 0.0
		if _player and _player.global_position.distance_to(global_position) < PLAGUE_RANGE:
			if _player.has_method("get") and _player.get("status") != null:
				_player.status.apply_poison(5, 5.0)
