extends "res://scripts/enemies/enemy_base.gd"

var _lightning_timer = 0.0

func _ready() -> void:
	max_health = 50
	attack_damage = 20
	move_speed = 75.0
	chase_range = 210.0
	attack_range = 100.0
	attack_cooldown = 99.0
	exp_reward = 38
	body_color = Color(0.8, 0.9, 0.3)
	body_size = 14
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_lightning_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _lightning_timer <= 0.0:
		_lightning_timer = 2.0
		if _player.has_method("take_damage"):
			_player.take_damage(attack_damage)
		for body in get_tree().get_nodes_in_group("enemies"):
			if body != self and body.global_position.distance_to(_player.global_position) < 60.0:
				if body.has_method("take_damage"):
					body.take_damage(int(attack_damage * 0.4), Vector2.ZERO)
