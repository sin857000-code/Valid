extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	weapon_name = "Void Blade"
	damage = 40
	range_radius = 60.0
	cooldown = 0.9
	item_color = Color(0.15, 0.0, 0.3)
	super._ready()
