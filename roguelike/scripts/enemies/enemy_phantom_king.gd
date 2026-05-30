extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 22
	move_speed = 60.0
	chase_range = 220.0
	attack_range = 22.0
	attack_cooldown = 1.0
	exp_reward = 55
	body_color = Color(0.7,0.5,1.0)
	body_size = 15
	super._ready()
