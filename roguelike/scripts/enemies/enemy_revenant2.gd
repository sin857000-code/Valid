extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 22
	move_speed = 65.0
	chase_range = 205.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 48
	body_color = Color(0.5,0.5,0.8)
	body_size = 15
	super._ready()
