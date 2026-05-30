extends "res://scripts/enemies/enemy_base.gd"

const DODGE_COOLDOWN = 3.0
const DODGE_CHANCE = 0.35

var _dodge_cooldown: float = 0.0

func _ready() -> void:
	max_health = 20
	attack_damage = 12
	move_speed = 110.0
	chase_range = 260.0
	attack_range = 18.0
	attack_cooldown = 0.9
	exp_reward = 20
	body_color = Color(0.1, 0.1, 0.2)
	body_size = 9
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	_dodge_cooldown = max(0.0, _dodge_cooldown - delta)

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if _dodge_cooldown <= 0.0 and randf() < DODGE_CHANCE:
		_dodge_cooldown = DODGE_COOLDOWN
		var dodge_pos = global_position + Vector2(randi_range(-25, 25), randi_range(-25, 25))
		global_position = dodge_pos
		modulate = Color(0.5, 0.5, 0.5)
		var t = create_tween()
		t.tween_property(self, "modulate", Color.WHITE, 0.2)
		return
	super.take_damage(amount, source_pos)
