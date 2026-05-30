extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 30
	attack_damage = 10
	move_speed = 100.0
	chase_range = 220.0
	attack_range = 14.0
	attack_cooldown = 0.6
	exp_reward = 22
	body_color = Color(0.8,0.95,1.0)
	body_size = 9
	super._ready()
