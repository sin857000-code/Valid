extends "res://scripts/enemies/enemy_base.gd"

const PETRIFY_RANGE = 90.0
const PETRIFY_INTERVAL = 5.0

var _petrify_timer: float = 2.0

func _ready() -> void:
	max_health = 38
	attack_damage = 10
	move_speed = 50.0
	chase_range = 220.0
	attack_range = 21.0
	attack_cooldown = 1.5
	exp_reward = 28
	body_color = Color(0.3, 0.7, 0.4)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_petrify_timer += delta
	if _petrify_timer >= PETRIFY_INTERVAL:
		_petrify_timer = 0.0
		if _player and _player.global_position.distance_to(global_position) < PETRIFY_RANGE:
			if _player.has_method("get") and _player.get("status") != null:
				_player.status.apply_slow(0.0, 1.5)
			var hp = load("res://scripts/ui/hit_particle.gd")
			hp.spawn(get_parent(), _player.global_position, Color(0.3, 0.7, 0.4))
