extends "res://scripts/enemies/enemy_base.gd"

var _teleport_timer = 0.0

func _ready() -> void:
	max_health = 30
	attack_damage = 32
	move_speed = 100.0
	chase_range = 220.0
	attack_range = 16.0
	attack_cooldown = 1.0
	exp_reward = 32
	body_color = Color(0.1, 0.1, 0.3)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_teleport_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist > 80.0 and _teleport_timer <= 0.0:
		_teleport_timer = 3.0
		global_position = _player.global_position + Vector2(randf_range(-40, 40), randf_range(-40, 40))
