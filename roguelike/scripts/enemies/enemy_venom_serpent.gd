extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 18
	move_speed = 75.0
	chase_range = 200.0
	attack_range = 18.0
	attack_cooldown = 0.9
	exp_reward = 36
	body_color = Color(0.2,0.8,0.2)
	body_size = 13
	super._ready()
