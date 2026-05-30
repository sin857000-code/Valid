extends "res://scripts/enemies/enemy_base.gd"

const WEB_RANGE = 100.0
const WEB_INTERVAL = 5.0

var _web_timer: float = 0.0

func _ready() -> void:
	max_health = 24
	attack_damage = 7
	move_speed = 85.0
	chase_range = 220.0
	attack_range = 18.0
	attack_cooldown = 1.2
	exp_reward = 16
	body_color = Color(0.3, 0.15, 0.05)
	body_size = 9
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_web_timer += delta
	if _web_timer >= WEB_INTERVAL:
		_web_timer = 0.0
		var dist = global_position.distance_to(_player.global_position)
		if dist < WEB_RANGE:
			_shoot_web()

func _shoot_web() -> void:
	if _player == null:
		return
	if _player.has_method("get") and _player.get("status") != null:
		_player.status.apply_slow(0.3, 2.0)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), _player.global_position, Color(0.7, 0.7, 0.5))
