extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 55
	attack_damage = 20
	move_speed = 65.0
	chase_range = 220.0
	attack_range = 20.0
	attack_cooldown = 1.0
	exp_reward = 40
	body_color = Color(0.6,0.5,1.0)
	body_size = 13
	super._ready()
