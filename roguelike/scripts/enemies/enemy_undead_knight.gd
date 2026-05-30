extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 22
	move_speed = 55.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 45
	body_color = Color(0.3, 0.3, 0.5)
	body_size = 12
	super._ready()
