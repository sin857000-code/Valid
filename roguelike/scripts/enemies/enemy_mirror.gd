extends "res://scripts/enemies/enemy_base.gd"

var _reflect_ready: bool = true
var _reflect_cooldown: float = 0.0

func _ready() -> void:
	max_health = 25
	attack_damage = 8
	move_speed = 55.0
	chase_range = 200.0
	attack_range = 22.0
	attack_cooldown = 1.5
	exp_reward = 18
	body_color = Color(0.7, 0.9, 1.0)
	body_size = 13
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _reflect_cooldown > 0.0:
		_reflect_cooldown -= delta
		if _reflect_cooldown <= 0.0:
			_reflect_ready = true

func take_damage(amount, source_pos = Vector2.ZERO) -> void:
	if _reflect_ready:
		_reflect_ready = false
		_reflect_cooldown = 2.0
		# Reflect 50% damage back to player
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var reflected = max(1, int(amount * 0.5))
			player.take_damage(reflected)
		var hp = load("res://scripts/ui/hit_particle.gd")
		hp.spawn(get_parent(), global_position, Color(0.5, 0.9, 1.0))
		# Show reflect indicator
		modulate = Color(0.3, 0.8, 1.0)
		var t = create_tween()
		t.tween_property(self, "modulate", Color.WHITE, 0.3)
	super.take_damage(amount, source_pos)
