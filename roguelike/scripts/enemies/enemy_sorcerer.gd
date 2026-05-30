extends "res://scripts/enemies/enemy_base.gd"

var _teleport_timer = 3.0
var _homing_timer = 3.0
const TELEPORT_RADIUS = 120.0

func _ready() -> void:
	max_health = 55
	attack_damage = 18
	move_speed = 55.0
	chase_range = 230.0
	attack_range = 180.0
	attack_cooldown = 99.0
	exp_reward = 48
	body_color = Color(0.15, 0.1, 0.5)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying or _player == null:
		return

	_teleport_timer -= delta
	if _teleport_timer <= 0.0:
		_teleport_timer = 3.0
		_do_teleport()

	_homing_timer -= delta
	if _homing_timer <= 0.0:
		_homing_timer = 3.0
		_fire_homing()

func _do_teleport() -> void:
	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * TELEPORT_RADIUS
	global_position += offset

func _fire_homing() -> void:
	if _player == null:
		return
	var dir = (_player.global_position - global_position).normalized()
	var proj = Node2D.new()
	proj.set_script(load("res://scripts/enemies/projectile.gd"))
	get_parent().add_child(proj)
	proj.global_position = global_position
	proj.setup(dir, attack_damage, 140.0)
	if proj.has_method("set_homing"):
		proj.set_homing(_player, 60.0)
