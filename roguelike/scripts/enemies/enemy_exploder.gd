extends "res://scripts/enemies/enemy_base.gd"

const EXPLODE_RANGE = 40.0

func _ready() -> void:
	max_health = 18
	attack_damage = 0
	move_speed = 90.0
	chase_range = 280.0
	attack_range = EXPLODE_RANGE
	attack_cooldown = 9999.0
	exp_reward = 12
	body_color = Color(1.0, 0.5, 0.0)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	if _dying or _player == null:
		return
	var dist = global_position.distance_to(_player.global_position)
	if dist < EXPLODE_RANGE:
		_explode()
		return
	elif dist < chase_range:
		velocity = (_player.global_position - global_position).normalized() * move_speed
	move_and_slide()

func _explode() -> void:
	_dying = true
	set_physics_process(false)
	# 폭발 파티클
	var hp = load("res://scripts/ui/hit_particle.gd")
	for i in range(3):
		hp.spawn(get_parent(), global_position + Vector2(randi_range(-10,10), randi_range(-10,10)), Color(1.0, 0.4, 0.0))
	_player.take_damage(25)
	enemy_died.emit(self)
	queue_free()
