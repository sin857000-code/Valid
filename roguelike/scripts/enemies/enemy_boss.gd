extends "res://scripts/enemies/enemy_base.gd"

const PHASE2_THRESHOLD = 0.5

var _phase2_activated: bool = false
var _summon_timer: float = 5.0

func _ready() -> void:
	max_health = 200 + GameManager.current_floor * 50
	attack_damage = 20
	move_speed = 45.0
	chase_range = 9999.0
	attack_range = 24.0
	attack_cooldown = 1.2
	exp_reward = 100
	body_color = Color(0.6, 0.1, 0.8)
	body_size = 24
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	if not _phase2_activated and current_health <= max_health * PHASE2_THRESHOLD:
		_activate_phase2()
	if _phase2_activated:
		_summon_timer -= delta
		if _summon_timer <= 0.0:
			_summon_timer = 5.0
			_summon_minion()

func _activate_phase2() -> void:
	_phase2_activated = true
	move_speed = 80.0
	attack_damage = 30
	attack_cooldown = 0.8
	body_color = Color(1.0, 0.1, 0.8)
	if _visual:
		_visual._base_color = body_color
		_visual._body.color = body_color

func _summon_minion() -> void:
	var minion = CharacterBody2D.new()
	minion.set_script(load("res://scripts/enemies/enemy_fast.gd"))
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 6.0
	col.shape = shape
	minion.add_child(col)
	get_parent().add_child(minion)
	minion.global_position = global_position + Vector2(randi_range(-50, 50), randi_range(-50, 50))
	minion.enemy_died.connect(func(e): pass)
