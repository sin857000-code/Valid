extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 140
	attack_damage = 30
	move_speed = 35.0
	chase_range = 180.0
	attack_range = 30.0
	attack_cooldown = 2.0
	exp_reward = 75
	body_color = Color(0.5,0.4,0.2)
	body_size = 22
	super._ready()
