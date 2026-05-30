extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 65
	attack_damage = 22
	move_speed = 55.0
	chase_range = 190.0
	attack_range = 24.0
	attack_cooldown = 1.3
	exp_reward = 38
	body_color = Color(0.5, 0.7, 1.0)
	body_size = 15
	super._ready()

func take_damage(amount, knockback_dir = Vector2.ZERO) -> void:
	super.take_damage(int(amount * 0.7), knockback_dir)
	if _player != null and _player.global_position.distance_to(global_position) < 60.0:
		if _player.has_node("StatusEffect"):
			_player.get_node("StatusEffect").apply_slow(0.35, 1.5)
