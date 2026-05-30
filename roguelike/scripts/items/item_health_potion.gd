extends "res://scripts/items/item_base.gd"

@export var heal_amount: int = 30

func _ready() -> void:
	item_name = "체력 포션"
	item_color = Color.GREEN
	super._ready()

func _apply_effect(player: Node) -> void:
	player.heal(heal_amount)
