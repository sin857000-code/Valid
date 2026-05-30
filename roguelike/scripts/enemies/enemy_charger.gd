extends "res://scripts/enemies/enemy_base.gd"

const CHARGE_RANGE = 160.0
const CHARGE_SPEED = 300.0
const CHARGE_DURATION = 0.4
const CHARGE_COOLDOWN = 4.0

var _charging: bool = false
var _charge_timer: float = 0.0
var _charge_cooldown: float = 0.0
var _charge_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	max_health = 32
	attack_damage = 18
	move_speed = 60.0
	chase_range = 220.0
	attack_range = 18.0
	attack_cooldown = 1.5
	exp_reward = 22
	body_color = Color(0.9, 0.4, 0.1)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		return
	if _charging:
		_charge_timer -= delta
		velocity = _charge_dir * CHARGE_SPEED
		move_and_slide()
		if _charge_timer <= 0.0:
			_charging = false
		return
	_charge_cooldown -= delta
	var dist = global_position.distance_to(_player.global_position)
	if dist < CHARGE_RANGE and _charge_cooldown <= 0.0:
		_charging = true
		_charge_timer = CHARGE_DURATION
		_charge_cooldown = CHARGE_COOLDOWN
		_charge_dir = (_player.global_position - global_position).normalized()
		modulate = Color(2.0, 0.8, 0.3)
		var t = create_tween()
		t.tween_property(self, "modulate", Color.WHITE, 0.2)
		return
	super._physics_process(delta)
