extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 40
	attack_damage = 18
	move_speed = 55.0
	chase_range = 230.0
	attack_range = 180.0
	attack_cooldown = 1.6
	exp_reward = 34
	body_color = Color(0.7,0.8,0.9)
	body_size = 12
	super._ready()
