extends "res://scripts/enemies/enemy_base.gd"

const HEAL_RANGE = 80.0
const HEAL_AMOUNT = 5
const HEAL_INTERVAL = 2.5

var _heal_timer: float = 0.0

func _ready() -> void:
	max_health = 22
	attack_damage = 3
	move_speed = 50.0
	chase_range = 250.0
	attack_range = 20.0
	attack_cooldown = 1.8
	exp_reward = 20
	body_color = Color(0.3, 1.0, 0.5)
	body_size = 11
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _dying:
		return
	_heal_timer += delta
	if _heal_timer >= HEAL_INTERVAL:
		_heal_timer = 0.0
		_heal_nearby()

func _heal_nearby() -> void:
	for body in get_tree().get_nodes_in_group("enemy"):
		if body == self:
			continue
		if body.global_position.distance_to(global_position) < HEAL_RANGE:
			if body.has_method("get") and body.get("current_health") != null:
				body.current_health = min(body.current_health + HEAL_AMOUNT, body.max_health)
				if body.has_method("get") and body.get("_visual") != null:
					body._visual.update_hp(float(body.current_health) / float(body.max_health))
				var hp = load("res://scripts/ui/hit_particle.gd")
				hp.spawn(get_parent(), body.global_position, Color(0.3, 1.0, 0.5))
