extends "res://scripts/enemies/enemy_base.gd"

const REGEN_RATE = 3
const REGEN_INTERVAL = 1.0

var _regen_timer: float = 0.0

func _ready() -> void:
	max_health = 55
	attack_damage = 7
	move_speed = 50.0
	chase_range = 200.0
	attack_range = 19.0
	attack_cooldown = 1.4
	exp_reward = 18
	body_color = Color(0.2, 0.9, 0.3)
	body_size = 14
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_regen_timer += delta
	if _regen_timer >= REGEN_INTERVAL:
		_regen_timer = 0.0
		if current_health < max_health:
			current_health = min(current_health + REGEN_RATE, max_health)
			_visual.update_hp(float(current_health) / float(max_health))
