extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 20
	move_speed = 100.0
	chase_range = 210.0
	attack_range = 18.0
	attack_cooldown = 0.8
	exp_reward = 35
	body_color = Color(0.5,0.4,0.3)
	body_size = 14
	super._ready()
