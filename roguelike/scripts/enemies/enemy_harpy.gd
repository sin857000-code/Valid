extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 38
	attack_damage = 15
	move_speed = 100.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 30
	body_color = Color(0.6, 0.4, 0.6)
	body_size = 12
	super._ready()
