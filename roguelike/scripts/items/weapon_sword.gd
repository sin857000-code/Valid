extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	item_name = "롱소드"
	item_color = Color.LIGHT_BLUE
	weapon_name = "롱소드"
	damage = 18
	range_radius = 40.0
	cooldown = 0.6   # 강하지만 느림
	super._ready()
