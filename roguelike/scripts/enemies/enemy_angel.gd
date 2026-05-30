extends "res://scripts/enemies/enemy_base.gd"

const HEAL_INTERVAL = 3.0

var _heal_timer: float = 0.0

func _ready() -> void:
	max_health = 40
	attack_damage = 12
	move_speed = 60.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 1.1
	exp_reward = 25
	body_color = Color(1.0, 1.0, 0.7)
	body_size = 13
	super._ready()
	modulate = Color(1.0, 1.0, 0.8)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_heal_timer += delta
	if _heal_timer >= HEAL_INTERVAL:
		_heal_timer = 0.0
		# Heal self
		if current_health < max_health:
			current_health = min(current_health + 8, max_health)
			if _visual:
				_visual.update_hp(float(current_health) / float(max_health))
