extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 40
	attack_damage = 18
	move_speed = 110.0
	chase_range = 190.0
	attack_range = 18.0
	attack_cooldown = 1.0
	exp_reward = 30
	body_color = Color(0.1, 0.1, 0.2)
	body_size = 12
	super._ready()
