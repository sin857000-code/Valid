extends "res://scripts/items/item_base.gd"

@export var bonus_damage: int = 5

func _ready() -> void:
	item_name = "공격력 업"
	item_color = Color.CYAN
	super._ready()

func _apply_effect(player: Node) -> void:
	player.attack_damage += bonus_damage
