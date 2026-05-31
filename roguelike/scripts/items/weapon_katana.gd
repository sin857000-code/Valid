extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Katana"
	damage = 26
	range_radius = 50.0
	cooldown = 0.4
	item_color = Color(0.9, 0.9, 0.9)
	super._ready()
