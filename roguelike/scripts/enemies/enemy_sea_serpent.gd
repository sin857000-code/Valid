extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 22
	move_speed = 70.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 1.1
	exp_reward = 45
	body_color = Color(0.2,0.6,0.7)
	body_size = 15
	super._ready()
