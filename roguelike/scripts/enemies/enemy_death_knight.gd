extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 75
	attack_damage = 22
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 24.0
	attack_cooldown = 1.3
	exp_reward = 42
	body_color = Color(0.2, 0.1, 0.3)
	body_size = 16
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	super.take_damage(int(amount * 0.75), source_pos)
	# Drains player's max health
	var player = get_tree().get_first_node_in_group("player")
	if player and global_position.distance_to(player.global_position) < 28.0:
		player.max_health = max(10, player.max_health - 1)
		player.current_health = min(player.current_health, player.max_health)
		player.health_changed.emit(player.current_health, player.max_health)
