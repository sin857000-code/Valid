extends "res://scripts/enemies/enemy_base.gd"

var _scream_timer = 0.0

func _ready() -> void:
	max_health = 38
	attack_damage = 14
	move_speed = 60.0
	chase_range = 200.0
	attack_range = 90.0
	attack_cooldown = 2.0
	exp_reward = 28
	body_color = Color(0.8, 0.8, 1.0)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_scream_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _scream_timer <= 0.0:
		_scream_timer = 4.0
		if _player.has_method("take_damage"):
			_player.take_damage(attack_damage)
		if _player.has_node("StatusEffect"):
			_player.get_node("StatusEffect").apply_slow(0.4, 2.5)
