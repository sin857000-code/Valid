extends Node2D

# Random floor events - triggered by walking into special room area

const EVENTS = ["blessing", "curse", "mystery"]

var _event_type: String = ""
var _triggered: bool = false
var _area: Area2D

func setup(pos: Vector2) -> void:
	global_position = pos
	_event_type = EVENTS[randi() % EVENTS.size()]

	_area = Area2D.new()
	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 18.0
	col.shape = shape
	_area.add_child(col)
	add_child(_area)
	_area.body_entered.connect(_on_body_entered)

	var visual = ColorRect.new()
	match _event_type:
		"blessing":
			visual.color = Color(1.0, 1.0, 0.3, 0.7)
		"curse":
			visual.color = Color(0.5, 0.0, 0.5, 0.7)
		"mystery":
			visual.color = Color(0.5, 0.5, 0.5, 0.7)
	visual.size = Vector2(20, 20)
	visual.position = Vector2(-10, -10)
	add_child(visual)

	var lbl = Label.new()
	match _event_type:
		"blessing": lbl.text = "?"
		"curse": lbl.text = "!"
		"mystery": lbl.text = "*"
	lbl.position = Vector2(-5, -10)
	lbl.add_theme_font_size_override("font_size", 16)
	add_child(lbl)

func _on_body_entered(body: Node) -> void:
	if _triggered or not body.is_in_group("player"):
		return
	_triggered = true
	match _event_type:
		"blessing":
			body.heal(int(body.max_health * 0.25))
			body.attack_damage = int(body.attack_damage * 1.1)
		"curse":
			body.max_health = max(10, int(body.max_health * 0.85))
			body.current_health = min(body.current_health, body.max_health)
			body.health_changed.emit(body.current_health, body.max_health)
		"mystery":
			# Random: could be good or bad
			if randf() < 0.5:
				body.heal(30)
			else:
				body.take_damage(15)
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		var msgs = {"blessing": "축복! HP+25% ATK+10%", "curse": "저주! MaxHP-15%", "mystery": "신비한 힘!"}
		hud.show_weapon_pickup(msgs.get(_event_type, ""))
	queue_free()
