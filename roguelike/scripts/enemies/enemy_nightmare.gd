extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 65
	attack_damage = 25
	move_speed = 80.0
	chase_range = 220.0
	attack_range = 20.0
	attack_cooldown = 0.9
	exp_reward = 50
	body_color = Color(0.2,0.0,0.4)
	body_size = 15
	super._ready()
