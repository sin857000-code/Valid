extends CharacterBody2D

signal health_changed(current: int, max: int)
signal player_died

const SPEED = 150.0

@export var max_health: int = 100
@export var attack_damage: int = 10

var current_health: int

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount
	current_health = max(current_health, 0)
	health_changed.emit(current_health, max_health)
	if current_health == 0:
		player_died.emit()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)

func attack(target: Node) -> void:
	if target.has_method("take_damage"):
		target.take_damage(attack_damage)
