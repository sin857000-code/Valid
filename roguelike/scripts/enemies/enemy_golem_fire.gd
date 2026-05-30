extends "res://scripts/enemies/enemy_base.gd"

var _fire_trail_timer = 0.0
var _damage_mult = 0.5

func _ready() -> void:
	max_health = 80
	attack_damage = 20
	move_speed = 40.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.4
	exp_reward = 45
	body_color = Color(0.9, 0.3, 0.05)
	body_size = 16
	super._ready()

func take_damage(amount: float, knockback_dir: Vector2 = Vector2.ZERO) -> void:
	super.take_damage(amount * _damage_mult, knockback_dir)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return
	_fire_trail_timer -= delta
	if _fire_trail_timer <= 0.0:
		_fire_trail_timer = 0.4
		_spawn_fire_tile()

func _spawn_fire_tile() -> void:
	var marker = Node2D.new()
	marker.global_position = global_position
	get_parent().add_child(marker)
	var sprite = ColorRect.new()
	sprite.size = Vector2(8, 8)
	sprite.position = Vector2(-4, -4)
	sprite.color = Color(1.0, 0.5, 0.0, 0.8)
	marker.add_child(sprite)
	var timer = Timer.new()
	timer.wait_time = 1.5
	timer.one_shot = true
	marker.add_child(timer)
	timer.timeout.connect(marker.queue_free)
	timer.start()
	var dmg_timer = Timer.new()
	dmg_timer.wait_time = 0.5
	dmg_timer.one_shot = false
	marker.add_child(dmg_timer)
	dmg_timer.timeout.connect(_fire_tile_tick.bind(marker))
	dmg_timer.start()

func _fire_tile_tick(marker: Node2D) -> void:
	if not is_instance_valid(marker):
		return
	if _player == null:
		return
	if marker.global_position.distance_to(_player.global_position) < 14.0:
		if _player.has_method("take_damage"):
			_player.take_damage(4.0, Vector2.ZERO)
