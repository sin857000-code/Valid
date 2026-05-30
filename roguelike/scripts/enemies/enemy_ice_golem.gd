extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 70
	attack_damage = 18
	move_speed = 30.0
	chase_range = 180.0
	attack_range = 26.0
	attack_cooldown = 2.2
	exp_reward = 35
	body_color = Color(0.4, 0.8, 1.0)
	body_size = 20
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _attack_timer <= 0.0:
		if _player.has_method("get") and _player.get("status") != null:
			_player.status.apply_slow(0.4, 2.5)
