extends CharacterBody2D

signal health_changed(current: int, max: int)
signal player_died
signal item_collected(item_name: String)

const SPEED = 150.0

@export var max_health: int = 100
@export var attack_damage: int = 10
@export var attack_range: float = 30.0
@export var attack_cooldown: float = 0.4

var current_health: int
var _attack_timer: float = 0.0
var facing: Vector2 = Vector2.RIGHT

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)
	add_to_group("player")

func _physics_process(delta: float) -> void:
	_attack_timer -= delta

	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	if direction != Vector2.ZERO:
		facing = direction.normalized()
	move_and_slide()

	if Input.is_action_just_pressed("ui_accept") and _attack_timer <= 0.0:
		_do_attack()

func _do_attack() -> void:
	_attack_timer = attack_cooldown
	var attack_pos = global_position + facing * attack_range
	for body in get_tree().get_nodes_in_group("enemy"):
		if body.global_position.distance_to(attack_pos) < attack_range:
			body.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	current_health -= amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health, max_health)
	if current_health == 0:
		player_died.emit()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
