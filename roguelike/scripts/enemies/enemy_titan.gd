extends "res://scripts/enemies/enemy_base.gd"

var _stomp_timer: float = 0.0

func _ready() -> void:
	max_health = 150
	attack_damage = 30
	move_speed = 20.0
	chase_range = 160.0
	attack_range = 35.0
	attack_cooldown = 3.0
	exp_reward = 70
	body_color = Color(0.4, 0.4, 0.5)
	body_size = 30
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_stomp_timer += delta
	if _stomp_timer >= 5.0:
		_stomp_timer = 0.0
		_ground_stomp()

func _ground_stomp() -> void:
	if _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < 80.0:
		_player.take_damage(20)
	# Visual shockwave
	var ring = ColorRect.new()
	ring.size = Vector2(160, 160)
	ring.color = Color(0.6, 0.5, 0.4, 0.5)
	ring.global_position = global_position - Vector2(80, 80)
	get_parent().add_child(ring)
	var t = ring.create_tween().set_parallel(true)
	t.tween_property(ring, "scale", Vector2(1.5, 1.5), 0.4)
	t.tween_property(ring, "modulate:a", 0.0, 0.4)
	t.tween_callback(ring.queue_free).set_delay(0.4)

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	super.take_damage(max(1, int(amount * 0.5)), source_pos)
