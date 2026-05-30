extends CharacterBody2D

signal enemy_died(enemy: Node)

@export var max_health: int = 30
@export var attack_damage: int = 5
@export var move_speed: float = 60.0
@export var chase_range: float = 200.0
@export var attack_range: float = 18.0
@export var attack_cooldown: float = 1.0
@export var exp_reward: int = 10
@export var body_color: Color = Color.RED

var current_health: int
var _player: Node = null
var _attack_timer: float = 0.0

func _ready() -> void:
	current_health = max_health
	add_to_group("enemy")
	_player = get_tree().get_first_node_in_group("player")
	# 색상 박스 스프라이트 생성
	var rect = ColorRect.new()
	rect.size = Vector2(12, 12)
	rect.position = Vector2(-6, -6)
	rect.color = body_color
	add_child(rect)

func _physics_process(delta: float) -> void:
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
		velocity = velocity.move_toward(Vector2.ZERO, move_speed)

	move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		enemy_died.emit(self)
		queue_free()
