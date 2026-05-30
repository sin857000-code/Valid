extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 20
	move_speed = 100.0
	chase_range = 210.0
	attack_range = 18.0
	attack_cooldown = 0.8
	exp_reward = 40
	body_color = Color(0.8,0.9,0.3)
	body_size = 13
	super._ready()
