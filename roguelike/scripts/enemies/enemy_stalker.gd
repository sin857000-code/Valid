extends "res://scripts/enemies/enemy_base.gd"

var _stealth = true
var _reveal_timer = 0.0

func _ready() -> void:
	max_health = 40
	attack_damage = 25
	move_speed = 90.0
	chase_range = 250.0
	attack_range = 18.0
	attack_cooldown = 1.2
	exp_reward = 30
	body_color = Color(0.2, 0.2, 0.2, 0.3)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_reveal_timer -= delta
	var dist = global_position.distance_to(_player.global_position)
	if _stealth and dist < 60.0:
		_stealth = false
		modulate = Color(1, 1, 1, 1)
		attack_damage = 35
	if not _stealth and _reveal_timer <= 0.0:
		_stealth = true
		_reveal_timer = 5.0
		modulate = Color(1, 1, 1, 0.3)
		attack_damage = 25
