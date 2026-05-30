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
var move_speed_bonus: float = 1.0
var _attack_timer: float = 0.0
var _dash_timer: float = 0.0
var _dash_cooldown_timer: float = 0.0
var _is_dashing: bool = false
var facing: Vector2 = Vector2.RIGHT
var _visual: Node2D
var status: Node
var _combo: int = 0
var _combo_timer: float = 0.0
var _camera: Camera2D

func _ready() -> void:
	add_to_group("player")
	status = load("res://scripts/core/status_effect.gd").new()
	status.name = "StatusEffect"
	add_child(status)
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
	load("res://scripts/core/sound_manager.gd").play_level_up(self)
	var old_max = max_health
	_apply_level_stats(new_level)
	current_health += max_health - old_max
	current_health = min(current_health, max_health)
	health_changed.emit(current_health, max_health)

func _physics_process(delta: float) -> void:
	_attack_timer -= delta
	_dash_cooldown_timer -= delta
	if _combo_timer > 0.0:
		_combo_timer -= delta
		if _combo_timer <= 0.0:
			_combo = 0

	if _is_dashing:
		_dash_timer -= delta
		if _dash_timer <= 0.0:
			_is_dashing = false
			modulate.a = 1.0
		velocity = facing * DASH_SPEED
		move_and_slide()
		return

	status.tick(delta, self)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED * status.get_speed_factor() * move_speed_bonus
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
	modulate.a = 0.4
	_spawn_dash_trail()

func _spawn_dash_trail() -> void:
	for i in range(5):
		var trail = ColorRect.new()
		trail.size = Vector2(10, 10)
		trail.position = global_position - Vector2(5, 5) + Vector2(randf_range(-4, 4), randf_range(-4, 4))
		trail.color = Color(0.4, 0.7, 1.0, 0.7)
		get_parent().add_child(trail)
		var t = trail.create_tween()
		t.set_parallel(true)
		t.tween_property(trail, "modulate:a", 0.0, 0.25)
		t.tween_property(trail, "scale", Vector2(0.3, 0.3), 0.25)
		t.tween_callback(trail.queue_free).set_delay(0.25)

func _do_attack() -> void:
	_attack_timer = attack_cooldown
	_visual.flash_attack()
	load("res://scripts/core/sound_manager.gd").play_attack(self)
	var arc_mode = has_meta("attack_arc") and get_meta("attack_arc")
	var attack_pos = global_position + facing * attack_range
	var hit_any = false
	for body in get_tree().get_nodes_in_group("enemy"):
		var in_range = arc_mode and body.global_position.distance_to(global_position) < attack_range * 1.3
		in_range = in_range or body.global_position.distance_to(attack_pos) < attack_range
		if in_range:
			var is_crit = randf() < 0.12
			var dmg = attack_damage * (3 if is_crit else 1)
			_combo += 1
			_combo_timer = 2.5
			var combo_mult = 1.0 + (_combo / 10.0)
			dmg = int(dmg * combo_mult)
			body.take_damage(dmg, global_position)
			hit_any = true
			if is_crit:
				var hp = load("res://scripts/ui/hit_particle.gd")
				hp.spawn(get_parent(), body.global_position, Color(1.0, 0.6, 0.0))
	if not hit_any:
		_combo = 0

func take_damage(amount: int) -> void:
	if _is_dashing:
		return
	# 보호막 1회 차단
	if has_meta("shield") and get_meta("shield"):
		set_meta("shield", false)
		if has_meta("shield_visual"):
			get_meta("shield_visual").queue_free()
		return
	current_health -= amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health, max_health)
	_visual.flash_hit()
	load("res://scripts/core/sound_manager.gd").play_hit(self)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1, 0.3, 0.3))
	_screen_shake()
	if current_health == 0:
		player_died.emit()

func _screen_shake() -> void:
	if _camera == null:
		_camera = get_node_or_null("Camera2D")
	if _camera == null:
		return
	var tween = create_tween()
	for i in range(4):
		var offset = Vector2(randf_range(-4, 4), randf_range(-4, 4))
		tween.tween_property(_camera, "offset", offset, 0.04)
	tween.tween_property(_camera, "offset", Vector2.ZERO, 0.04)

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 1.0, 0.4))
