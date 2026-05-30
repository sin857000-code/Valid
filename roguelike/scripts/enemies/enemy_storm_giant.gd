extends "res://scripts/enemies/enemy_base.gd"

var _stomp_timer = 6.0
const STOMP_RADIUS = 80.0

func _ready() -> void:
	max_health = 130
	attack_damage = 28
	move_speed = 42.0
	chase_range = 180.0
	attack_range = 26.0
	attack_cooldown = 1.8
	exp_reward = 65
	body_color = Color(0.4, 0.55, 0.65)
	body_size = 20
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_stomp_timer -= delta
	if _stomp_timer <= 0.0:
		_stomp_timer = 6.0
		_do_stomp()

func _do_stomp() -> void:
	var flash = ColorRect.new()
	flash.size = Vector2(STOMP_RADIUS * 2, STOMP_RADIUS * 2)
	flash.position = Vector2(-STOMP_RADIUS, -STOMP_RADIUS)
	flash.color = Color(0.8, 0.9, 1.0, 0.5)
	add_child(flash)
	var t = Timer.new()
	t.wait_time = 0.25
	t.one_shot = true
	add_child(t)
	t.timeout.connect(flash.queue_free)
	t.start()

	if _player == null:
		return
	if global_position.distance_to(_player.global_position) <= STOMP_RADIUS:
		if _player.has_method("take_damage"):
			_player.take_damage(attack_damage * 1.5, (_player.global_position - global_position).normalized() * 2.0)
		if _player.has_node("StatusEffect"):
			_player.get_node("StatusEffect").apply_slow(0.4, 2.0)
