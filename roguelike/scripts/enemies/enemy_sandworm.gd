extends "res://scripts/enemies/enemy_base.gd"

var _burrow_timer = 0.0
var _burrowed = false

func _ready() -> void:
	max_health = 70
	attack_damage = 24
	move_speed = 60.0
	chase_range = 200.0
	attack_range = 18.0
	attack_cooldown = 1.5
	exp_reward = 40
	body_color = Color(0.7, 0.5, 0.2)
	body_size = 16
	super._ready()

func _physics_process(delta: float) -> void:
	if _burrowed:
		_burrow_timer -= delta
		if _burrow_timer <= 0.0:
			_burrowed = false
			modulate = Color(1, 1, 1, 1)
			if _player != null:
				global_position = _player.global_position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		return
	super._physics_process(delta)
	_burrow_timer -= delta
	if _burrow_timer <= 0.0:
		_burrow_timer = 6.0
		_burrowed = true
		modulate = Color(1, 1, 1, 0.0)
