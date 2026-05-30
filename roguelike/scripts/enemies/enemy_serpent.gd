extends "res://scripts/enemies/enemy_base.gd"

func _ready() -> void:
	max_health = 30
	attack_damage = 8
	move_speed = 80.0
	chase_range = 230.0
	attack_range = 18.0
	attack_cooldown = 0.9
	exp_reward = 16
	body_color = Color(0.1, 0.6, 0.2)
	body_size = 10
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

# Serpent applies poison on attack - override base attack behavior
func _apply_attack_effect() -> void:
	if _player and _player.has_method("get") and _player.get("status") != null:
		_player.status.apply_poison(3, 4.0)
