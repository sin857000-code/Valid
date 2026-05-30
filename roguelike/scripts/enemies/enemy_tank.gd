extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 80
	attack_damage = 12
	move_speed = 35.0
	chase_range = 150.0
	attack_range = 22.0
	attack_cooldown = 1.8
	exp_reward = 25
	body_color = Color.DARK_RED
	super._ready()
