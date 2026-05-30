extends "res://scripts/enemies/enemy_base.gd"

var _element: String = "fire"

func _ready() -> void:
	max_health = 35
	attack_damage = 12
	move_speed = 65.0
	chase_range = 210.0
	attack_range = 20.0
	attack_cooldown = 1.2
	exp_reward = 20
	_element = ["fire", "ice", "lightning"][randi() % 3]
	match _element:
		"fire": body_color = Color(1.0, 0.4, 0.1)
		"ice": body_color = Color(0.4, 0.8, 1.0)
		"lightning": body_color = Color(1.0, 1.0, 0.3)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _attack_timer <= 0.0:
		match _element:
			"ice":
				if _player.has_method("get") and _player.get("status") != null:
					_player.status.apply_slow(0.3, 1.5)
			"lightning":
				if _player.has_method("get") and _player.get("status") != null:
					_player.status.apply_slow(0.0, 0.3)
