extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 25
	attack_damage = 10
	move_speed = 95.0
	chase_range = 200.0
	attack_range = 12.0
	attack_cooldown = 0.6
	exp_reward = 18
	body_color = Color(0.5, 0.0, 0.1)
	body_size = 9
	super._ready()

func _on_attack_hit(player) -> void:
	current_health = min(current_health + 5, max_health)
