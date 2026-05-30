extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 22
	move_speed = 80.0
	chase_range = 210.0
	attack_range = 90.0
	attack_cooldown = 99.0
	exp_reward = 42
	body_color = Color(0.9,1.0,0.3)
	body_size = 14
	super._ready()
