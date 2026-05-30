extends "res://scripts/enemies/enemy_base.gd"

var _phase2 = false

func _ready() -> void:
	max_health = 55
	attack_damage = 20
	move_speed = 80.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 0.9
	exp_reward = 32
	body_color = Color(0.5, 0.3, 0.1)
	body_size = 14
	super._ready()

func take_damage(amount, knockback_dir = Vector2.ZERO) -> void:
	super.take_damage(amount, knockback_dir)
	if not _phase2 and _health < max_health * 0.5:
		_phase2 = true
		move_speed = 130.0
		attack_damage = 30
		body_color = Color(0.8, 0.1, 0.1)
