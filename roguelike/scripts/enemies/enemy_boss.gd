extends "res://scripts/enemies/enemy_base.gd"

# 페이즈 2 전환 임계값
const PHASE2_THRESHOLD = 0.5

var _phase2_activated: bool = false
var _summon_timer: float = 5.0

func _ready() -> void:
	max_health = 200 + GameManager.current_floor * 50
	attack_damage = 20
	move_speed = 45.0
	chase_range = 9999.0  # 항상 추적
	attack_range = 24.0
	attack_cooldown = 1.2
	exp_reward = 100
	body_color = Color.PURPLE
	super._ready()
	# 보스 크기 키우기
	for child in get_children():
		if child is ColorRect:
			child.size = Vector2(24, 24)
			child.position = Vector2(-12, -12)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	# 페이즈 2: 체력 50% 이하
	if not _phase2_activated and current_health <= max_health * PHASE2_THRESHOLD:
		_activate_phase2()

	# 페이즈 2: 주기적으로 졸개 소환
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
	# 색상 변경으로 페이즈 2 표시
	for child in get_children():
		if child is ColorRect:
			child.color = Color.MAGENTA

func _summon_minion() -> void:
	var minion = CharacterBody2D.new()
	minion.set_script(load("res://scripts/enemies/enemy_fast.gd"))
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 6.0
	col.shape = shape
	minion.add_child(col)
	get_parent().add_child(minion)
	minion.global_position = global_position + Vector2(randi_range(-40, 40), randi_range(-40, 40))
	minion.enemy_died.connect(func(e): e.queue_free())
