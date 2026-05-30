extends "res://scripts/enemies/enemy_base.gd"

const PHASE_DURATION = 2.0
const PHASE_COOLDOWN = 4.0

var _phased: bool = false
var _phase_timer: float = 0.0

func _ready() -> void:
	max_health = 28
	attack_damage = 9
	move_speed = 75.0
	chase_range = 240.0
	attack_range = 19.0
	attack_cooldown = 1.2
	exp_reward = 20
	body_color = Color(0.7, 0.7, 0.9)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_phase_timer += delta
	if not _phased and _phase_timer >= PHASE_COOLDOWN:
		_phase_timer = 0.0
		_enter_phase()
	elif _phased and _phase_timer >= PHASE_DURATION:
		_phase_timer = 0.0
		_exit_phase()

func _enter_phase() -> void:
	_phased = true
	modulate.a = 0.2
	# Cannot be damaged while phased

func _exit_phase() -> void:
	_phased = false
	modulate.a = 1.0

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if _phased:
		return
	super.take_damage(amount, source_pos)
