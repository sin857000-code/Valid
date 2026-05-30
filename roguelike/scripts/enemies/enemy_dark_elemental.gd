extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 60
	attack_damage = 22
	move_speed = 70.0
	chase_range = 205.0
	attack_range = 20.0
	attack_cooldown = 1.0
	exp_reward = 44
	body_color = Color(0.2,0.1,0.3)
	body_size = 14
	super._ready()
