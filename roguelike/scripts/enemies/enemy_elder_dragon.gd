extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 160
	attack_damage = 40
	move_speed = 50.0
	chase_range = 220.0
	attack_range = 30.0
	attack_cooldown = 1.5
	exp_reward = 100
	body_color = Color(0.7,0.1,0.1)
	body_size = 24
	super._ready()
