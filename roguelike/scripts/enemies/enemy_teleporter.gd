extends "res://scripts/enemies/enemy_base.gd"

const BLINK_COOLDOWN = 2.5
const BLINK_RANGE = 120.0

var _blink_timer: float = 1.0

func _ready() -> void:
	max_health = 22
	move_speed = 30.0
	attack_damage = 8
	attack_range = 16.0
	chase_range = 250.0
	exp_reward = 20
	body_color = Color(0.7, 0.3, 0.9)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_blink_timer -= delta
	if _blink_timer <= 0.0:
		_blink_timer = BLINK_COOLDOWN
		_do_blink()

func _do_blink() -> void:
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.7, 0.3, 0.9))
	# Blink toward player but not too close
	var dist = global_position.distance_to(_player.global_position)
	if dist > 40.0:
		var dir = (_player.global_position - global_position).normalized()
		var blink_dist = min(dist - 35.0, BLINK_RANGE)
		global_position += dir * blink_dist
	hp.spawn(get_parent(), global_position, Color(0.9, 0.6, 1.0))
