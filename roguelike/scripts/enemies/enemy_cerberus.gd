extends "res://scripts/enemies/enemy_base.gd"

var _bite_timer = 0.0

func _ready() -> void:
	max_health = 85
	attack_damage = 24
	move_speed = 85.0
	chase_range = 220.0
	attack_range = 20.0
	attack_cooldown = 0.8
	exp_reward = 52
	body_color = Color(0.7, 0.1, 0.0)
	body_size = 17
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_bite_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < attack_range and _bite_timer <= 0.0:
		_bite_timer = 3.0
		if _player.has_method("take_damage"):
			_player.take_damage(attack_damage * 2)
