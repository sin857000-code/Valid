extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 120
	attack_damage = 25
	move_speed = 30.0
	chase_range = 180.0
	attack_range = 30.0
	attack_cooldown = 2.5
	exp_reward = 50
	body_color = Color(0.5, 0.3, 0.1)
	body_size = 28
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	# Giants take 25% reduced damage
	super.take_damage(max(1, int(amount * 0.75)), source_pos)
