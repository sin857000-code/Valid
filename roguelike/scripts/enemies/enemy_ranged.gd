extends "res://scripts/enemies/enemy_base.gd"

const SHOOT_RANGE  = 180.0
const SHOOT_COOLDOWN = 1.8
const FLEE_RANGE   = 80.0

var _shoot_timer: float = 1.0

func _ready() -> void:
	max_health = 20
	attack_damage = 0  # 근접 공격 안 함
	move_speed = 50.0
	chase_range = 220.0
	attack_range = 9999.0  # 근접 판정 무효
	exp_reward = 15
	body_color = Color(0.2, 0.8, 0.4)
	body_size = 10
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		return
	_shoot_timer -= delta
	var dist = global_position.distance_to(_player.global_position)

	if dist < FLEE_RANGE:
		# 너무 가까우면 도망
		velocity = (global_position - _player.global_position).normalized() * move_speed
	elif dist > SHOOT_RANGE:
		# 사거리 밖이면 접근
		velocity = (_player.global_position - global_position).normalized() * move_speed * 0.7
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_speed)

	move_and_slide()

	if _shoot_timer <= 0.0 and dist <= SHOOT_RANGE:
		_shoot_timer = SHOOT_COOLDOWN
		_fire_projectile()

func _fire_projectile() -> void:
	var burst = 3 if GameManager.current_floor >= 8 else 1
	for i in range(burst):
		var proj = Node2D.new()
		proj.set_script(load("res://scripts/enemies/projectile.gd"))
		get_parent().add_child(proj)
		proj.global_position = global_position
		var spread = Vector2(randf_range(-0.15, 0.15), randf_range(-0.15, 0.15))
		proj.setup(_player.global_position - global_position + spread * 80, 8, 150.0)
