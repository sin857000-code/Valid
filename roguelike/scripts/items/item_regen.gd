extends "res://scripts/items/item_base.gd"

func _ready() -> void:
	item_name = "재생 반지"
	item_color = Color(0.4, 1.0, 0.7)
	super._ready()

func _apply_effect(player: Node) -> void:
	var current = player.get_meta("regen_rate") if player.has_meta("regen_rate") else 0.0
	player.set_meta("regen_rate", current + 0.5)  # 0.5 HP/sec per stack
