extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 65
	attack_damage = 22
	move_speed = 65.0
	chase_range = 195.0
	attack_range = 20.0
	attack_cooldown = 1.1
	exp_reward = 44
	body_color = Color(1.0,0.4,0.0)
	body_size = 15
	super._ready()
