extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 20
	move_speed = 90.0
	chase_range = 220.0
	attack_range = 18.0
	attack_cooldown = 0.9
	exp_reward = 36
	body_color = Color(0.1,0.1,0.2)
	body_size = 12
	super._ready()
