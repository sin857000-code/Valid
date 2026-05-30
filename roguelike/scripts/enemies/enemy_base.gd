extends CharacterBody2D

signal enemy_died(enemy: Node)

@export var max_health: int = 30
@export var attack_damage: int = 5
@export var move_speed: float = 60.0
@export var chase_range: float = 200.0
@export var attack_range: float = 18.0
@export var attack_cooldown: float = 1.0
@export var exp_reward: int = 10
@export var body_color: Color = Color(0.9, 0.2, 0.2)
@export var body_size: int = 12

var current_health: int
var _player: Node = null
var _attack_timer: float = 0.0
var _visual: Node2D
var _dying: bool = false
var _wander_dir: Vector2 = Vector2.RIGHT
var _wander_timer: float = 0.0
var _stun_timer: float = 0.0

func _ready() -> void:
	add_to_group("enemy")
	current_health = max_health
	_player = get_tree().get_first_node_in_group("player")

	_visual = load("res://scripts/enemies/enemy_visual.gd").new()
	add_child(_visual)
	_visual.setup(body_color, body_size)

	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = body_size / 2.0
	col.shape = shape
	add_child(col)

func _physics_process(delta: float) -> void:
	if _stun_timer > 0.0:
		_stun_timer -= delta
		velocity = Vector2.ZERO
		return
	if _dying or _player == null:
		if _player == null:
			_player = get_tree().get_first_node_in_group("player")
		return

	_attack_timer -= delta
	var dist = global_position.distance_to(_player.global_position)

	if dist < attack_range:
		velocity = Vector2.ZERO
		if _attack_timer <= 0.0:
			_attack_timer = attack_cooldown
			_player.take_damage(attack_damage)
	elif dist < chase_range:
		velocity = (_player.global_position - global_position).normalized() * move_speed
	else:
		_wander_timer -= get_physics_process_delta_time()
		if _wander_timer <= 0.0:
			_wander_timer = randf_range(1.5, 3.0)
			var angle = randf() * TAU
			_wander_dir = Vector2(cos(angle), sin(angle))
		velocity = velocity.move_toward(_wander_dir * move_speed * 0.4, move_speed * 0.5)

	move_and_slide()

func take_damage(amount: int, source_pos: Vector2 = Vector2.ZERO) -> void:
	if _dying:
		return
	current_health -= amount
	current_health = max(current_health, 0)
	_visual.update_hp(float(current_health) / float(max_health))
	_visual.flash_hit()

	if source_pos != Vector2.ZERO:
		var kb_dir = (global_position - source_pos).normalized()
		velocity += kb_dir * 180.0

	var dn = load("res://scripts/ui/damage_number.gd")
	dn.spawn(get_parent(), global_position, amount)

	if current_health == 0:
		_dying = true
		set_physics_process(false)
		_visual.death_anim(func(): enemy_died.emit(self); queue_free())
