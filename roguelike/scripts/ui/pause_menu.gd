extends CanvasLayer

var _overlay: ColorRect
var _panel: Panel
var _visible: bool = false

func _ready() -> void:
	layer = 20
	process_mode = Node.PROCESS_MODE_ALWAYS

	_overlay = ColorRect.new()
	_overlay.color = Color(0, 0, 0, 0.55)
	_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(_overlay)

	_panel = Panel.new()
	_panel.size = Vector2(200, 140)
	_panel.set_anchors_preset(Control.PRESET_CENTER)
	_panel.position -= _panel.size / 2
	add_child(_panel)

	var vbox = VBoxContainer.new()
	vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	vbox.add_theme_constant_override("separation", 14)
	_panel.add_child(vbox)

	var title = Label.new()
	title.text = "PAUSED"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 20)
	vbox.add_child(title)

	var resume_btn = Button.new()
	resume_btn.text = "Resume"
	resume_btn.pressed.connect(_toggle_pause)
	vbox.add_child(resume_btn)

	var menu_btn = Button.new()
	menu_btn.text = "Main Menu"
	menu_btn.pressed.connect(func():
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn"))
	vbox.add_child(menu_btn)

	_set_visible(false)

func _input(event: InputEvent) -> void:
	if event.is_action_just_pressed("ui_cancel"):
		_toggle_pause()

func _toggle_pause() -> void:
	_visible = not _visible
	get_tree().paused = _visible
	_set_visible(_visible)

func _set_visible(v: bool) -> void:
	_overlay.visible = v
	_panel.visible = v
