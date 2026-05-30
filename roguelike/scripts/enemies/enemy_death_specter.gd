extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 18
	move_speed = 70.0
	chase_range = 220.0
	attack_range = 20.0
	attack_cooldown = 0.9
	exp_reward = 40
	body_color = Color(0.4,0.4,0.8)
	body_size = 13
	super._ready()
