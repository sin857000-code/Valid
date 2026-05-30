extends Area2D

const TILE = 16

var _rect: ColorRect
var _lid: ColorRect
var _opened: bool = false

func _ready() -> void:
	add_to_group("chest")

	var shape = CollisionShape2D.new()
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Vector2(14, 14)
	shape.shape = rect_shape
	add_child(shape)

	# Chest body
	_rect = ColorRect.new()
	_rect.size = Vector2(14, 14)
	_rect.position = Vector2(-7, -7)
	_rect.color = Color(0.6, 0.4, 0.1)
	add_child(_rect)

	# Lid (top strip)
	_lid = ColorRect.new()
	_lid.size = Vector2(14, 4)
	_lid.position = Vector2(-7, -7)
	_lid.color = Color(0.8, 0.6, 0.15)
	add_child(_lid)

	# Gold lock dot
	var lock = ColorRect.new()
	lock.size = Vector2(4, 4)
	lock.position = Vector2(-2, -2)
	lock.color = Color(1.0, 0.85, 0.2)
	add_child(lock)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _opened or not body.is_in_group("player"):
		return
	_opened = true
	_open_chest(body)

func _open_chest(player: Node) -> void:
	var hp = load("res://scripts/ui/hit_particle.gd")
	hp.spawn(get_parent(), global_position, Color(1.0, 0.85, 0.2))

	# Lid fly-off animation
	var tween = _lid.create_tween().set_parallel(true)
	tween.tween_property(_lid, "position:y", -30.0, 0.3)
	tween.tween_property(_lid, "modulate:a", 0.0, 0.3)

	# Spawn 1-3 random items nearby
	var item_scripts = [
		"res://scripts/items/item_health_potion.gd",
		"res://scripts/items/item_attack_up.gd",
		"res://scripts/items/item_shield.gd",
		"res://scripts/items/item_speed_up.gd",
		"res://scripts/items/item_rage.gd",
		"res://scripts/items/item_regen.gd",
	]
	var count = randi_range(1, 3)
	for i in range(count):
		var item = Area2D.new()
		item.set_script(load(item_scripts[randi() % item_scripts.size()]))
		get_parent().add_child(item)
		item.global_position = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))

	_rect.color = Color(0.35, 0.22, 0.06)
	await get_tree().create_timer(0.5).timeout
	queue_free()
