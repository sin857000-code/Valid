extends Area2D

const HEAL_AMOUNT = 30
const USE_INTERVAL = 10.0

var _used: bool = false
var _cooldown: float = 0.0
var _visual: ColorRect

func _ready() -> void:
	_visual = ColorRect.new()
	_visual.size = Vector2(16, 16)
	_visual.position = Vector2(-8, -8)
	_visual.color = Color(0.2, 0.7, 1.0, 0.8)
	add_child(_visual)

	var lbl = Label.new()
	lbl.text = "+"
	lbl.add_theme_font_size_override("font_size", 14)
	lbl.position = Vector2(-5, -10)
	lbl.modulate = Color(1.0, 1.0, 1.0)
	add_child(lbl)

	var col = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 12.0
	col.shape = shape
	add_child(col)

	var pulse = _visual.create_tween().set_loops()
	pulse.tween_property(_visual, "color", Color(0.4, 0.9, 1.0, 0.9), 0.8)
	pulse.tween_property(_visual, "color", Color(0.1, 0.5, 0.9, 0.6), 0.8)

	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if _cooldown > 0.0:
		_cooldown -= delta
		if _cooldown <= 0.0:
			_visual.color = Color(0.2, 0.7, 1.0, 0.8)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player") or _cooldown > 0.0:
		return
	_cooldown = USE_INTERVAL
	body.heal(HEAL_AMOUNT)
	_visual.color = Color(0.5, 0.5, 0.5, 0.5)
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(0.3, 0.8, 1.0))
