extends "res://scripts/items/weapon_base.gd"

func _ready() -> void:
	item_name = "단검"
	item_color = Color.SILVER
	weapon_name = "단검"
	damage = 8
	range_radius = 22.0
	cooldown = 0.2   # 빠르지만 짧은 사거리
	super._ready()
