extends "res://scripts/enemies/enemy_base.gd"

const POISON_RANGE = 35.0
const POISON_COOLDOWN = 2.5

var _poison_timer: float = 0.0

func _ready() -> void:
	max_health = 25
	attack_damage = 3
	move_speed = 55.0
	chase_range = 220.0
	attack_range = POISON_RANGE
	attack_cooldown = 9999.0
	exp_reward = 14
	body_color = Color(0.3, 0.7, 0.2)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_poison_timer -= delta
	if _player and global_position.distance_to(_player.global_position) < POISON_RANGE:
		if _poison_timer <= 0.0:
			_poison_timer = POISON_COOLDOWN
			_apply_poison_to_player()

func _apply_poison_to_player() -> void:
	# StatusEffect 컴포넌트가 있으면 독 적용
	var se = _player.get_node_or_null("StatusEffect")
	if se:
		se.apply_poison(4, 4.0)
	else:
		# 없으면 직접 데미지
		_player.take_damage(6)
