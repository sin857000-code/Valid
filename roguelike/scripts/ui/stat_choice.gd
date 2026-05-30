extends CanvasLayer

# Shows 3 stat upgrade choices when player levels up.
# Pauses the game until a choice is made.

const CHOICES = [
	{"label": "❤ +Max HP  +30", "key": "hp", "color": Color(0.9, 0.3, 0.3)},
	{"label": "⚔ +Attack  +8", "key": "atk", "color": Color(1.0, 0.7, 0.2)},
	{"label": "⚡ +Speed  +20%", "key": "spd", "color": Color(0.3, 0.8, 1.0)},
]

var _panel: Panel
var _player: Node = null

func _ready() -> void:
	layer = 15
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.level_up.connect(_on_level_up)
	_panel = Panel.new()
	_panel.size = Vector2(320, 180)
	_panel.set_anchors_preset(Control.PRESET_CENTER)
	_panel.position -= _panel.size / 2
	_panel.visible = false
	add_child(_panel)

	var vbox = VBoxContainer.new()
	vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	vbox.add_theme_constant_override("separation", 10)
	_panel.add_child(vbox)

	var title = Label.new()
	title.text = "LEVEL UP — Choose a stat:"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 16)
	vbox.add_child(title)

	for choice in CHOICES:
		var btn = Button.new()
		btn.text = choice["label"]
		btn.modulate = choice["color"]
		btn.pressed.connect(_on_choice.bind(choice["key"]))
		vbox.add_child(btn)

func _on_level_up(_new_level: int) -> void:
	_player = get_tree().get_first_node_in_group("player")
	_panel.visible = true
	get_tree().paused = true

func _on_choice(key: String) -> void:
	if _player == null or not is_instance_valid(_player):
		_close()
		return
	match key:
		"hp":
			_player.max_health += 30
			_player.current_health = min(_player.current_health + 30, _player.max_health)
			_player.health_changed.emit(_player.current_health, _player.max_health)
		"atk":
			_player.attack_damage += 8
		"spd":
			_player.move_speed_bonus = min(_player.move_speed_bonus + 0.20, 3.0)
	_close()

func _close() -> void:
	_panel.visible = false
	get_tree().paused = false
