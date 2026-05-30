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
var damage_free_time: float = 0.0
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
var _bomb_cooldown: float = 0.0
const BOMB_COOLDOWN = 8.0
const BOMB_RANGE = 80.0
const BOMB_DAMAGE = 35

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
		if has_meta("dash_attack") and get_meta("dash_attack"):
			for body in get_tree().get_nodes_in_group("enemy"):
				if global_position.distance_to(body.global_position) < 16.0:
					body.take_damage(int(attack_damage * 0.5), global_position)
		return

	damage_free_time += delta
	if has_meta("vampire_aura") and get_meta("vampire_aura") and current_health < max_health:
		for body in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(body.global_position) < 50.0:
				var drain = 1
				heal(drain)
				break
	if has_meta("regen_rate") and current_health < max_health:
		var regen_acc = get_meta("regen_acc") if has_meta("regen_acc") else 0.0
		regen_acc += delta * get_meta("regen_rate")
		if regen_acc >= 1.0:
			heal(int(regen_acc))
			regen_acc = fmod(regen_acc, 1.0)
		set_meta("regen_acc", regen_acc)
	_physics_process_invincible(delta)
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

	# 폭탄: E (ui_end)
	_bomb_cooldown -= delta
	if Input.is_action_just_pressed("ui_end") and _bomb_cooldown <= 0.0:
		_do_bomb()

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
	_visual.show_attack_range(attack_range)
	load("res://scripts/core/sound_manager.gd").play_attack(self)
	# Auto-aim: snap facing toward nearest enemy within 1.5x attack range
	var best_dist = attack_range * 1.5
	for body in get_tree().get_nodes_in_group("enemy"):
		var d = global_position.distance_to(body.global_position)
		if d < best_dist:
			best_dist = d
			facing = (body.global_position - global_position).normalized()
			_visual.update_facing(facing)
	var arc_mode = has_meta("attack_arc") and get_meta("attack_arc")
	var multi_mode = has_meta("multishot") and get_meta("multishot")
	var attack_pos = global_position + facing * attack_range
	var hit_any = false
	for body in get_tree().get_nodes_in_group("enemy"):
		var body_dir = body.global_position - global_position
		var scythe = has_meta("scythe_mode") and get_meta("scythe_mode")
		var pierce = has_meta("pierce_shot") and get_meta("pierce_shot")
		var in_arc = arc_mode and body.global_position.distance_to(global_position) < (attack_range * 1.8 if scythe else attack_range * 1.3)
		var in_pierce = pierce and body.global_position.distance_to(global_position) < attack_range and body_dir.normalized().dot(facing) > 0.7
		var in_cone = multi_mode and body_dir.length() < attack_range * 1.2 and body_dir.normalized().dot(facing) > 0.5
		var in_range = in_arc or in_cone or in_pierce or body.global_position.distance_to(attack_pos) < attack_range
		if in_range:
			var crit_chance = 0.12 + (get_meta("crit_bonus") if has_meta("crit_bonus") else 0.0)
			var is_crit = randf() < crit_chance
			var rage_mult = get_meta("rage_dmg_mult") if has_meta("rage_dmg_mult") else 1.0
			var adrenaline_mult = 1.0
			if has_meta("adrenaline") and get_meta("adrenaline"):
				var hp_ratio = float(current_health) / float(max_health)
				adrenaline_mult = 1.0 + (1.0 - hp_ratio) * 1.5
			var dmg = int(attack_damage * (3 if is_crit else 1) * rage_mult * adrenaline_mult)
			_combo += 1
			_combo_timer = 2.5
			var combo_mult = 1.0 + (_combo / 10.0)
			dmg = int(float(dmg) * combo_mult)
			body.take_damage(dmg, global_position)
			if has_meta("freeze_on_hit") and get_meta("freeze_on_hit"):
				if body.has_method("get") and body.get("status") != null:
					body.status.apply_slow(0.2, 1.8)
			if has_meta("stun_on_hit") and get_meta("stun_on_hit"):
				if body.has_method("get") and body.get("_stun_timer") != null:
					body._stun_timer = 0.5
			if has_meta("explosive_shots") and get_meta("explosive_shots"):
				var explosion_pos = body.global_position
				var explosion = ColorRect.new()
				explosion.size = Vector2(24, 24)
				explosion.color = Color(1.0, 0.5, 0.1, 0.7)
				explosion.global_position = explosion_pos - Vector2(12, 12)
				get_parent().add_child(explosion)
				var et = explosion.create_tween().set_parallel(true)
				et.tween_property(explosion, "scale", Vector2(2.0, 2.0), 0.3)
				et.tween_property(explosion, "modulate:a", 0.0, 0.3)
				et.tween_callback(explosion.queue_free).set_delay(0.3)
				for nb in get_tree().get_nodes_in_group("enemy"):
					if nb != body and nb.global_position.distance_to(explosion_pos) < 25.0:
						nb.take_damage(int(attack_damage * 0.3), explosion_pos)
			if has_meta("lifesteal"):
				var steal = int(dmg * get_meta("lifesteal"))
				if steal > 0:
					heal(steal)
			hit_any = true
			if is_crit:
				var hp = load("res://scripts/ui/hit_particle.gd")
				hp.spawn(get_parent(), body.global_position, Color(1.0, 0.6, 0.0))
	if not hit_any:
		_combo = 0
	if has_meta("bouncing_shots") and get_meta("bouncing_shots"):
		_fire_player_projectile()
	if has_meta("chain_lightning") and get_meta("chain_lightning") and hit_any:
		_do_chain_lightning()

func _do_chain_lightning() -> void:
	var targets = []
	for body in get_tree().get_nodes_in_group("enemy"):
		targets.append(body)
	targets.sort_custom(func(a, b): return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position))
	var chain_count = min(3, targets.size())
	for i in range(chain_count):
		var t = targets[i]
		var bolt_dmg = int(attack_damage * 0.5)
		t.take_damage(bolt_dmg, global_position)
		var bolt = ColorRect.new()
		bolt.size = Vector2(4, 4)
		bolt.color = Color(1.0, 1.0, 0.3, 0.9)
		bolt.global_position = t.global_position - Vector2(2, 2)
		get_parent().add_child(bolt)
		var bt = bolt.create_tween()
		bt.tween_property(bolt, "modulate:a", 0.0, 0.2).set_delay(i * 0.05)
		bt.tween_callback(bolt.queue_free)

func _fire_player_projectile() -> void:
	var proj = Node2D.new()
	proj.set_script(load("res://scripts/enemies/projectile.gd"))
	get_parent().add_child(proj)
	proj.global_position = global_position
	proj.setup(facing, attack_damage, 180.0)
	proj.set_meta("player_proj", true)
	proj.set_meta("dmg_override", attack_damage)

func _physics_process_invincible(delta: float) -> void:
	if has_meta("invincible_timer"):
		var t = get_meta("invincible_timer") - delta
		if t <= 0.0:
			remove_meta("invincible_timer")
		else:
			set_meta("invincible_timer", t)
	if has_meta("rage_timer"):
		var rt = get_meta("rage_timer") - delta
		if rt <= 0.0:
			remove_meta("rage_timer")
			if has_meta("rage_dmg_mult"):
				remove_meta("rage_dmg_mult")
		else:
			set_meta("rage_timer", rt)
	if has_meta("power_surge_timer"):
		var pt = get_meta("power_surge_timer") - delta
		if pt <= 0.0:
			remove_meta("power_surge_timer")
			if has_meta("power_surge_base"):
				attack_damage = get_meta("power_surge_base")
				remove_meta("power_surge_base")
		else:
			set_meta("power_surge_timer", pt)

func take_damage(amount: int) -> void:
	if _is_dashing:
		return
	if has_meta("invincible_timer") and get_meta("invincible_timer") > 0.0:
		return
	# 보호막 1회 차단
	if has_meta("shield") and get_meta("shield"):
		set_meta("shield", false)
		if has_meta("shield_visual"):
			get_meta("shield_visual").queue_free()
		return
	damage_free_time = 0.0
	if has_meta("thorns_dmg"):
		var thorns = get_meta("thorns_dmg")
		for body in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(body.global_position) < 40.0:
				body.take_damage(thorns, global_position)
				break
	if has_meta("damage_reduction"):
		amount = max(1, int(amount * (1.0 - get_meta("damage_reduction"))))
	current_health -= amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health, max_health)
	_visual.flash_hit()
	load("res://scripts/core/sound_manager.gd").play_hit(self)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1, 0.3, 0.3))
	_screen_shake()
	if current_health == 0:
		if has_meta("second_chance") and get_meta("second_chance"):
			remove_meta("second_chance")
			current_health = int(max_health * 0.3)
			health_changed.emit(current_health, max_health)
			_visual.flash_hit()
			var hud = get_tree().get_first_node_in_group("hud")
			if hud:
				hud.show_weapon_pickup("부활!")
			return
		_play_death_anim()

func _play_death_anim() -> void:
	set_physics_process(false)
	load("res://scripts/core/sound_manager.gd").play_hit(self)
	for i in range(3):
		var ring = ColorRect.new()
		ring.size = Vector2(16, 16)
		ring.position = Vector2(-8, -8)
		ring.color = Color(1.0, 0.3, 0.2, 0.8)
		get_parent().add_child(ring)
		ring.global_position = global_position - Vector2(8, 8)
		var t = ring.create_tween().set_parallel(true)
		t.tween_property(ring, "scale", Vector2(3.0, 3.0), 0.4).set_delay(i * 0.12)
		t.tween_property(ring, "modulate:a", 0.0, 0.4).set_delay(i * 0.12)
		t.tween_callback(ring.queue_free).set_delay(0.52 + i * 0.12)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1.0, 0.2, 0.2))
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.3).set_delay(0.2)
	tween.tween_callback(func(): player_died.emit())

func _do_bomb() -> void:
	_bomb_cooldown = BOMB_COOLDOWN
	# Expanding ring visual
	for i in range(3):
		var ring = ColorRect.new()
		ring.size = Vector2(BOMB_RANGE * 2, BOMB_RANGE * 2)
		ring.position = global_position - Vector2(BOMB_RANGE, BOMB_RANGE)
		ring.color = Color(1.0, 0.6, 0.1, 0.5)
		get_parent().add_child(ring)
		var t = ring.create_tween().set_parallel(true)
		t.tween_property(ring, "scale", Vector2(1.5, 1.5), 0.4).set_delay(i * 0.1)
		t.tween_property(ring, "modulate:a", 0.0, 0.4).set_delay(i * 0.1)
		t.tween_callback(ring.queue_free).set_delay(0.5 + i * 0.1)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1.0, 0.5, 0.1))
	for body in get_tree().get_nodes_in_group("enemy"):
		if body.global_position.distance_to(global_position) < BOMB_RANGE:
			body.take_damage(BOMB_DAMAGE, global_position)
	_screen_shake()

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
