extends "res://scripts/enemies/enemy_base.gd"

const SLOW_RANGE = 60.0
const SLOW_COOLDOWN = 3.0

var _slow_timer: float = 0.0

func _ready() -> void:
	max_health = 25
	move_speed = 50.0
	attack_damage = 6
	chase_range = 180.0
	exp_reward = 18
	body_color = Color(0.4, 0.7, 1.0)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_slow_timer -= delta
	if _slow_timer <= 0.0 and global_position.distance_to(_player.global_position) < SLOW_RANGE:
		_slow_timer = SLOW_COOLDOWN
		_player.status.apply_slow(0.45, 2.5)
		var hp = load("res://scripts/ui/hit_particle.gd")
		hp.spawn(get_parent(), _player.global_position, Color(0.4, 0.7, 1.0))
