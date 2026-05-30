extends "res://scripts/enemies/enemy_base.gd"

const ARMOR_REDUCTION = 0.35

func _ready() -> void:
	max_health = 90
	attack_damage = 35
	move_speed = 25.0
	chase_range = 160.0
	attack_range = 24.0
	attack_cooldown = 2.0
	exp_reward = 50
	body_color = Color(0.5, 0.45, 0.35)
	body_size = 18
	super._ready()

func take_damage(amount: float, knockback_dir: Vector2 = Vector2.ZERO) -> void:
	super.take_damage(amount * (1.0 - ARMOR_REDUCTION), knockback_dir * 0.3)
