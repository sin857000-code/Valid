extends "res://scripts/enemies/enemy_base.gd"

var _enraged: bool = false

func _ready() -> void:
	max_health = 45
	attack_damage = 12
	move_speed = 65.0
	chase_range = 200.0
	attack_range = 20.0
	attack_cooldown = 1.0
	exp_reward = 25
	body_color = Color(0.8, 0.2, 0.1)
	body_size = 14
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	super.take_damage(amount, source_pos)
	if not _enraged and float(current_health) / float(max_health) < 0.4:
		_enrage()

func _enrage() -> void:
	_enraged = true
	move_speed = 130.0
	attack_damage = 22
	attack_cooldown = 0.5
	modulate = Color(2.0, 0.5, 0.3)
	var t = create_tween()
	t.tween_property(self, "modulate", Color.WHITE, 0.4)
	if _visual:
		_visual._base_color = Color(1.0, 0.1, 0.0)
		_visual._body.color = Color(1.0, 0.1, 0.0)
