extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 20
	move_speed = 55.0
	chase_range = 220.0
	attack_range = 22.0
	attack_cooldown = 1.2
	exp_reward = 38
	body_color = Color(0.2,0.1,0.4)
	body_size = 13
	super._ready()
