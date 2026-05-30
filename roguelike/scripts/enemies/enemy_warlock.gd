extends "res://scripts/enemies/enemy_base.gd"

var _curse_timer = 0.0

func _ready() -> void:
	max_health = 42
	attack_damage = 18
	move_speed = 50.0
	chase_range = 210.0
	attack_range = 25.0
	attack_cooldown = 1.6
	exp_reward = 30
	body_color = Color(0.5, 0.0, 0.5)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_curse_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < 180.0 and _curse_timer <= 0.0:
		_curse_timer = 5.0
		if _player.has_meta("attack_mult"):
			_player.set_meta("attack_mult", _player.get_meta("attack_mult") * 0.8)
		if _player.has_method("take_damage"):
			_player.take_damage(attack_damage)
