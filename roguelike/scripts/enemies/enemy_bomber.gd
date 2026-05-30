extends "res://scripts/enemies/enemy_base.gd"

const BOMB_RANGE = 70.0
const BOMB_INTERVAL = 4.0
const BOMB_DAMAGE = 20

var _bomb_timer: float = 0.0

func _ready() -> void:
	max_health = 28
	attack_damage = 10
	move_speed = 60.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.5
	exp_reward = 20
	body_color = Color(0.8, 0.4, 0.0)
	body_size = 12
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_bomb_timer += delta
	if _bomb_timer >= BOMB_INTERVAL:
		_bomb_timer = 0.0
		var dist = global_position.distance_to(_player.global_position) if _player else 9999.0
		if dist < BOMB_RANGE:
			_throw_bomb()

func _throw_bomb() -> void:
	var expl = ColorRect.new()
	expl.size = Vector2(BOMB_RANGE * 2, BOMB_RANGE * 2)
	expl.color = Color(1.0, 0.5, 0.1, 0.6)
	expl.global_position = global_position - Vector2(BOMB_RANGE, BOMB_RANGE)
	get_parent().add_child(expl)
	var t = expl.create_tween().set_parallel(true)
	t.tween_property(expl, "scale", Vector2(1.3, 1.3), 0.3)
	t.tween_property(expl, "modulate:a", 0.0, 0.3)
	t.tween_callback(expl.queue_free).set_delay(0.3)
	if _player and _player.global_position.distance_to(global_position) < BOMB_RANGE:
		_player.take_damage(BOMB_DAMAGE)
