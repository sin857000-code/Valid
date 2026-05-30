extends "res://scripts/enemies/enemy_base.gd"

var _fake_deaths: int = 0

func _ready() -> void:
	max_health = 28
	attack_damage = 10
	move_speed = 90.0
	chase_range = 230.0
	attack_range = 17.0
	attack_cooldown = 0.9
	exp_reward = 20
	body_color = Color(0.9, 0.5, 0.9)
	body_size = 10
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if current_health - amount <= 0 and _fake_deaths < 1:
		_fake_deaths += 1
		# Fake death and teleport away
		var flee_pos = global_position + Vector2(randi_range(-60, 60), randi_range(-60, 60))
		global_position = flee_pos
		current_health = int(max_health * 0.4)
		if _visual:
			_visual.update_hp(float(current_health) / float(max_health))
		modulate = Color(2.0, 0.5, 2.0)
		var t = create_tween()
		t.tween_property(self, "modulate", Color.WHITE, 0.3)
		return
	super.take_damage(amount, source_pos)
