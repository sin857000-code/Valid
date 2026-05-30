extends "res://scripts/enemies/enemy_base.gd"

var _has_revived = false

func _ready() -> void:
	max_health = 60
	attack_damage = 17
	move_speed = 58.0
	chase_range = 180.0
	attack_range = 20.0
	attack_cooldown = 1.1
	exp_reward = 38
	body_color = Color(0.85, 0.82, 0.7)
	body_size = 14
	super._ready()

func take_damage(amount, knockback_dir = Vector2.ZERO) -> void:
	if not _has_revived and current_health - amount <= 0:
		_has_revived = true
		current_health = 30
		max_health = 30
		modulate = Color(0.7, 0.7, 1.0, 0.85)
		return
	super.take_damage(amount, knockback_dir)
