extends Node2D

const ITEMS = [
	"res://scripts/items/item_health_potion.gd",
	"res://scripts/items/item_attack_up.gd",
	"res://scripts/items/item_shield.gd",
	"res://scripts/items/item_speed_up.gd",
	"res://scripts/items/item_regen.gd",
]
const WEAPONS = [
	"res://scripts/items/weapon_sword.gd",
	"res://scripts/items/weapon_boomerang.gd",
	"res://scripts/items/weapon_staff.gd",
]
const COSTS = [30, 50, 80]

var _stall_labels: Array = []

func setup(pos: Vector2) -> void:
	global_position = pos
	var bg = ColorRect.new()
	bg.size = Vector2(80, 20)
	bg.position = Vector2(-40, -30)
	bg.color = Color(0.2, 0.15, 0.1, 0.8)
	add_child(bg)
	var lbl = Label.new()
	lbl.text = "SHOP"
	lbl.add_theme_font_size_override("font_size", 10)
	lbl.position = Vector2(-15, -28)
	lbl.modulate = Color(1.0, 0.9, 0.3)
	add_child(lbl)

	for i in range(3):
		var cost = COSTS[i]
		var pool = ITEMS if i < 2 else WEAPONS
		var script_path = pool[randi() % pool.size()]
		var stall = Area2D.new()
		stall.set_script(load("res://scripts/maps/shop_stall.gd"))
		add_child(stall)
		stall.setup(Vector2(-32 + i * 32, 0), script_path, cost)
