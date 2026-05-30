extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 16
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 30
	body_color = Color(0.3, 0.1, 0.5)
	body_size = 15
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	# Absorbs 30% of damage as max health drain
	var drained = int(amount * 0.3)
	max_health = max(1, max_health - drained)
	current_health = min(current_health, max_health)
	super.take_damage(int(amount * 0.7), source_pos)
