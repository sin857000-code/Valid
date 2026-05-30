extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 26
	move_speed = 65.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 54
	body_color = Color(0.9,0.4,0.1)
	body_size = 16
	super._ready()
