extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 45
	attack_damage = 18
	move_speed = 95.0
	chase_range = 220.0
	attack_range = 18.0
	attack_cooldown = 0.9
	exp_reward = 32
	body_color = Color(0.7,0.7,0.9)
	body_size = 13
	super._ready()
