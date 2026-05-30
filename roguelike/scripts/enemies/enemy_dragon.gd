extends "res://scripts/enemies/enemy_base.gd"

const BREATH_RANGE = 90.0
const BREATH_INTERVAL = 3.5

var _breath_timer: float = 0.0

func _ready() -> void:
	max_health = 80
	attack_damage = 20
	move_speed = 50.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.5
	exp_reward = 45
	body_color = Color(0.8, 0.2, 0.0)
	body_size = 18
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_breath_timer += delta
	if _breath_timer >= BREATH_INTERVAL:
		_breath_timer = 0.0
		var dist = global_position.distance_to(_player.global_position) if _player else 9999.0
		if dist < BREATH_RANGE:
			_fire_breath()

func _fire_breath() -> void:
	if _player == null:
		return
	var dir = (_player.global_position - global_position).normalized()
	for i in range(5):
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		var spread = Vector2(randf_range(-0.3, 0.3), randf_range(-0.3, 0.3))
		proj.global_position = global_position
		proj.setup((dir + spread).normalized(), attack_damage, 150.0)
