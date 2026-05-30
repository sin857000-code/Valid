extends CharacterBody2D

signal health_changed(current: int, max_hp: int)
signal player_died

const SPEED = 150.0
const DASH_SPEED = 500.0
const DASH_DURATION = 0.15
const DASH_COOLDOWN = 0.8

@export var max_health: int = 100
@export var attack_damage: int = 10
@export var attack_range: float = 30.0
@export var attack_cooldown: float = 0.4

var current_health: int
var _attack_timer: float = 0.0
var _dash_timer: float = 0.0
var _dash_cooldown_timer: float = 0.0
var _is_dashing: bool = false
var facing: Vector2 = Vector2.RIGHT
var _visual: Node2D

func _ready() -> void:
	add_to_group("player")
	_apply_level_stats(GameManager.level)
	current_health = max_health
	health_changed.emit(current_health, max_health)
	GameManager.level_up.connect(_on_level_up)

	_visual = load("res://scripts/player/player_visual.gd").new()
	add_child(_visual)

	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 7.0
	col.shape = shape
	add_child(col)

func _apply_level_stats(lv: int) -> void:
	max_health = 100 + (lv - 1) * 20
	attack_damage = 10 + (lv - 1) * 3

func _on_level_up(new_level: int) -> void:
	var old_max = max_health
	_apply_level_stats(new_level)
	current_health += max_health - old_max
	current_health = min(current_health, max_health)
	health_changed.emit(current_health, max_health)

func _physics_process(delta: float) -> void:
	_attack_timer -= delta
	_dash_cooldown_timer -= delta

	if _is_dashing:
		_dash_timer -= delta
		if _dash_timer <= 0.0:
			_is_dashing = false
			modulate.a = 1.0
		velocity = facing * DASH_SPEED
		move_and_slide()
		return

	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	if direction != Vector2.ZERO:
		facing = direction.normalized()
		_visual.update_facing(facing)
	move_and_slide()

	# 대시: Shift
	if Input.is_action_just_pressed("ui_page_up") and _dash_cooldown_timer <= 0.0:
		_start_dash()

	# 공격: Space
	if Input.is_action_just_pressed("ui_accept") and _attack_timer <= 0.0:
		_do_attack()

func _start_dash() -> void:
	_is_dashing = true
	_dash_timer = DASH_DURATION
	_dash_cooldown_timer = DASH_COOLDOWN
	modulate.a = 0.4  # 반투명으로 무적 느낌

func _do_attack() -> void:
	_attack_timer = attack_cooldown
	_visual.flash_attack()
	var attack_pos = global_position + facing * attack_range
	for body in get_tree().get_nodes_in_group("enemy"):
		if body.global_position.distance_to(attack_pos) < attack_range:
			body.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	if _is_dashing:  # 대시 중 무적
		return
	current_health -= amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health, max_health)
	_visual.flash_hit()
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1, 0.3, 0.3))
	if current_health == 0:
		player_died.emit()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 1.0, 0.4))
