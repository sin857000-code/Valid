extends "res://scripts/enemies/enemy_base.gd"

const SPELL_INTERVAL = 4.0
var _spell_timer: float = 1.0

func _ready() -> void:
	max_health = 55
	attack_damage = 14
	move_speed = 40.0
	chase_range = 280.0
	attack_range = 25.0
	attack_cooldown = 1.8
	exp_reward = 35
	body_color = Color(0.3, 0.3, 0.5)
	body_size = 14
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_spell_timer += delta
	if _spell_timer >= SPELL_INTERVAL:
		_spell_timer = 0.0
		_cast_death_bolt()

func _cast_death_bolt() -> void:
	if _player == null:
		return
	# Fires 3 homing-ish projectiles in a spread
	for i in range(-1, 2):
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		var base_dir = (_player.global_position - global_position).normalized()
		var angle = atan2(base_dir.y, base_dir.x) + i * 0.25
		var dir = Vector2(cos(angle), sin(angle))
		proj.setup(dir, 16, 140.0)
