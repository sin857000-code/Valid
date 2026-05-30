extends Node

# 상태이상 관리 컴포넌트 - 적이나 플레이어에 붙여 사용
signal effect_applied(effect_name: String)
signal effect_expired(effect_name: String)

var _effects: Dictionary = {}  # effect_name → {timer, data}

func _process(delta: float) -> void:
	for name in _effects.keys():
		var e = _effects[name]
		e["timer"] -= delta
		if e["timer"] <= 0.0:
			_expire(name)

func apply_poison(damage_per_tick: int, duration: float, tick_interval: float = 0.5) -> void:
	if _effects.has("poison"):
		_effects["poison"]["timer"] = duration  # 갱신
		return
	_effects["poison"] = {
		"timer": duration,
		"tick_timer": tick_interval,
		"tick_interval": tick_interval,
		"damage": damage_per_tick,
	}
	effect_applied.emit("poison")

func apply_slow(factor: float, duration: float) -> void:
	if _effects.has("slow"):
		_effects["slow"]["timer"] = maxf(_effects["slow"]["timer"], duration)
		return
	_effects["slow"] = {"timer": duration, "factor": factor}
	effect_applied.emit("slow")

func get_speed_factor() -> float:
	if _effects.has("slow"):
		return _effects["slow"]["factor"]
	return 1.0

func tick(delta: float, owner_node: Node) -> void:
	if _effects.has("poison"):
		var e = _effects["poison"]
		e["tick_timer"] -= delta
		if e["tick_timer"] <= 0.0:
			e["tick_timer"] = e["tick_interval"]
			if owner_node.has_method("take_damage"):
				owner_node.take_damage(e["damage"])
			# 초록 파티클
			var hp = load("res://scripts/ui/hit_particle.gd")
			hp.spawn(owner_node.get_parent(), owner_node.global_position, Color(0.2, 0.9, 0.2))

func is_active(effect_name: String) -> bool:
	return _effects.has(effect_name)

func _expire(name: String) -> void:
	_effects.erase(name)
	effect_expired.emit(name)
