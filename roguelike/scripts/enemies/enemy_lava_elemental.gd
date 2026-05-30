extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 50
	attack_damage = 15
	move_speed = 45.0
	chase_range = 180.0
	attack_range = 25.0
	attack_cooldown = 1.5
	exp_reward = 28
	body_color = Color(1.0, 0.4, 0.0)
	body_size = 16
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	# Immune to fire (explosive_shots, bomb_cooldown damage)
	super.take_damage(max(1, int(amount * 0.8)), source_pos)
	# Leave burning trail
	var lava = Area2D.new()
	lava.set_script(load("res://scripts/maps/lava_tile.gd"))
	get_parent().add_child(lava)
	lava.global_position = global_position
	var t = lava.create_tween()
	t.tween_interval(2.0)
	t.tween_callback(lava.queue_free)
