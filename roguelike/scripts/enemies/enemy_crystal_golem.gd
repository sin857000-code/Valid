extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 100
	attack_damage = 25
	move_speed = 40.0
	chase_range = 190.0
	attack_range = 26.0
	attack_cooldown = 1.6
	exp_reward = 60
	body_color = Color(0.7,0.95,1.0)
	body_size = 19
	super._ready()
