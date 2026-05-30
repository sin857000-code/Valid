extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 28
	attack_damage = 9
	move_speed = 110.0
	chase_range = 200.0
	attack_range = 14.0
	attack_cooldown = 0.9
	exp_reward = 20
	body_color = Color(0.35, 0.3, 0.1)
	body_size = 10
	super._ready()

func _on_attack_landed() -> void:
	if _player == null:
		return
	if _player.has_node("StatusEffect"):
		_player.get_node("StatusEffect").apply_poison(3.0, 4.0)
