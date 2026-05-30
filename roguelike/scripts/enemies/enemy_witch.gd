extends "res://scripts/enemies/enemy_base.gd"

const CURSE_RANGE = 130.0
const CURSE_INTERVAL = 4.5

var _curse_timer: float = 0.0

func _ready() -> void:
	max_health = 26
	attack_damage = 7
	move_speed = 45.0
	chase_range = 250.0
	attack_range = 25.0
	attack_cooldown = 1.8
	exp_reward = 22
	body_color = Color(0.6, 0.1, 0.6)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_curse_timer += delta
	if _curse_timer >= CURSE_INTERVAL:
		_curse_timer = 0.0
		if _player and _player.global_position.distance_to(global_position) < CURSE_RANGE:
			_cast_curse()

func _cast_curse() -> void:
	if _player.has_meta("rage_dmg_mult"):
		_player.remove_meta("rage_dmg_mult")
	if _player.has_meta("shield") and _player.get_meta("shield"):
		_player.set_meta("shield", false)
		if _player.has_meta("shield_visual"):
			_player.get_meta("shield_visual").queue_free()
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), _player.global_position, Color(0.6, 0.1, 0.6))
