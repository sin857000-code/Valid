extends CharacterBody2D

signal enemy_died(enemy: Node)

const SPEED = 60.0
const CHASE_RANGE = 200.0
const ATTACK_RANGE = 20.0
const ATTACK_COOLDOWN = 1.0

@export var max_health: int = 30
@export var attack_damage: int = 5
@export var exp_reward: int = 10

var current_health: int
var player: Node = null
var attack_timer: float = 0.0

func _ready() -> void:
	current_health = max_health
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null:
		return

	attack_timer -= delta
	var distance = global_position.distance_to(player.global_position)

	if distance < ATTACK_RANGE:
		_try_attack()
	elif distance < CHASE_RANGE:
		_chase_player()
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _chase_player() -> void:
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * SPEED

func _try_attack() -> void:
	if attack_timer <= 0.0:
		attack_timer = ATTACK_COOLDOWN
		player.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	current_health -= amount
	current_health = max(current_health, 0)
	if current_health == 0:
		_die()

func _die() -> void:
	enemy_died.emit(self)
	queue_free()
