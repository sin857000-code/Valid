extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 65
	attack_damage = 20
	move_speed = 50.0
	chase_range = 190.0
	attack_range = 22.0
	attack_cooldown = 1.2
	exp_reward = 45
	body_color = Color(0.4,0.6,0.2)
	body_size = 15
	super._ready()
