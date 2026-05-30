extends "res://scripts/enemies/enemy_base.gd"

var _revived: bool = false

func _ready() -> void:
	max_health = 40
	attack_damage = 11
	move_speed = 60.0
	chase_range = 210.0
	attack_range = 19.0
	attack_cooldown = 1.2
	exp_reward = 20
	body_color = Color(0.5, 0.5, 0.7)
	body_size = 12
	super._ready()

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	super.take_damage(amount, source_pos)
	if current_health == 0 and not _revived:
		# Will be revived in death anim — override by healing
		_revived = true
		current_health = int(max_health * 0.3)
		if _visual:
			_visual.update_hp(float(current_health) / float(max_health))
		_dying = false
		set_physics_process(true)
		modulate = Color(0.5, 0.5, 1.0)
		var t = create_tween()
		t.tween_property(self, "modulate", Color.WHITE, 0.5)
