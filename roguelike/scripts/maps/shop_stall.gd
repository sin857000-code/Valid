extends Area2D

var _script_path: String = ""
var _cost: int = 30
var _sold: bool = false
var _label: Label

func setup(offset: Vector2, script_path: String, cost: int) -> void:
	position = offset
	_script_path = script_path
	_cost = cost

	var visual = ColorRect.new()
	visual.size = Vector2(20, 20)
	visual.position = Vector2(-10, -10)
	visual.color = Color(0.8, 0.7, 0.2)
	add_child(visual)

	_label = Label.new()
	_label.text = "%d pts" % cost
	_label.add_theme_font_size_override("font_size", 9)
	_label.position = Vector2(-12, 12)
	add_child(_label)

	var col = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(20, 20)
	col.shape = shape
	add_child(col)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _sold or not body.is_in_group("player"):
		return
	if GameManager.score >= _cost:
		GameManager.score -= _cost
		_sold = true
		var hud = get_tree().get_first_node_in_group("hud")
		if hud:
			hud.update_score(GameManager.score)
		var item_script = load(_script_path)
		var temp = Area2D.new()
		temp.set_script(item_script)
		get_tree().root.add_child(temp)
		temp._apply_effect(body)
		temp.queue_free()
		modulate = Color(0.4, 0.4, 0.4)
		_label.text = "SOLD"
