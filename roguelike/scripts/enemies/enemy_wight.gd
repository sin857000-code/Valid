extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 60
	attack_damage = 20
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.1
	exp_reward = 40
	body_color = Color(0.6,0.6,0.8)
	body_size = 14
	super._ready()
