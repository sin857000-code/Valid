extends CanvasLayer

@onready var health_bar: ProgressBar = $Panel/VBox/HealthBar
@onready var exp_bar: ProgressBar = $Panel/VBox/ExpBar
@onready var dash_bar: ProgressBar = $Panel/VBox/DashBar
@onready var floor_label: Label = $Panel/VBox/FloorLabel
@onready var score_label: Label = $Panel/VBox/ScoreLabel
@onready var level_label: Label = $Panel/VBox/LevelLabel
@onready var boss_alert: Label = $BossAlert
@onready var weapon_label: Label = $WeaponLabel
@onready var minimap: Control = $Minimap
@onready var level_up_popup: CanvasLayer = $LevelUpPopup

var _player: Node = null
var _combo_label: Label = null
var _boss_bar_bg: ColorRect = null
var _boss_bar: ColorRect = null
var _boss_label: Label = null
var _boss: Node = null

func _ready() -> void:
	GameManager.level_up.connect(_on_level_up)
	_refresh_exp()
	_combo_label = Label.new()
	_combo_label.add_theme_font_size_override("font_size", 18)
	_combo_label.modulate = Color(1.0, 0.8, 0.2, 0.0)
	_combo_label.position = Vector2(8, 130)
	add_child(_combo_label)

	# Boss HP bar (bottom center, hidden by default)
	_boss_bar_bg = ColorRect.new()
	_boss_bar_bg.color = Color(0.15, 0.05, 0.15)
	_boss_bar_bg.size = Vector2(300, 18)
	_boss_bar_bg.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	_boss_bar_bg.position = Vector2(-150, -40)
	_boss_bar_bg.visible = false
	add_child(_boss_bar_bg)

	_boss_bar = ColorRect.new()
	_boss_bar.color = Color(0.8, 0.1, 0.8)
	_boss_bar.size = Vector2(300, 18)
	_boss_bar.position = Vector2.ZERO
	_boss_bar_bg.add_child(_boss_bar)

	_boss_label = Label.new()
	_boss_label.text = "BOSS"
	_boss_label.add_theme_font_size_override("font_size", 12)
	_boss_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_boss_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_boss_bar_bg.add_child(_boss_label)

func _process(_delta: float) -> void:
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")
		return
	var cd = _player._dash_cooldown_timer
	var ratio = 1.0 - clamp(cd / _player.DASH_COOLDOWN, 0.0, 1.0)
	dash_bar.value = ratio * 100.0
	dash_bar.modulate = Color(0.4, 0.9, 1.0) if ratio >= 1.0 else Color(0.6, 0.6, 0.6)
	# boss HP bar
	if _boss == null:
		_boss = get_tree().get_first_node_in_group("boss")
	if _boss != null and is_instance_valid(_boss) and not _boss.is_queued_for_deletion():
		_boss_bar_bg.visible = true
		var boss_ratio = float(_boss.current_health) / float(_boss.max_health)
		_boss_bar.size.x = 300.0 * boss_ratio
		_boss_bar.color = Color(0.8, 0.1, 0.8) if boss_ratio > 0.5 else Color(1.0, 0.1, 0.5)
	else:
		_boss_bar_bg.visible = false
		_boss = null

	# combo display
	var combo = _player._combo
	if combo >= 2:
		_combo_label.text = "x%d COMBO" % combo
		_combo_label.modulate.a = min(1.0, _combo_label.modulate.a + 0.15)
	else:
		_combo_label.modulate.a = max(0.0, _combo_label.modulate.a - 0.05)

func update_health(current: int, maximum: int) -> void:
	health_bar.max_value = maximum
	health_bar.value = current
	var ratio = float(current) / float(maximum)
	health_bar.modulate = Color(1.0, ratio * 0.85, ratio * 0.2)

func update_floor(floor_num: int) -> void:
	var theme_name = "Cave"
	if floor_num >= 16:
		theme_name = "Hell"
	elif floor_num >= 11:
		theme_name = "Crypt"
	elif floor_num >= 6:
		theme_name = "Dungeon"
	floor_label.text = "F%d  %s" % [floor_num, theme_name]

func update_score(s: int) -> void:
	score_label.text = "Score  %d" % s
	_refresh_exp()

func _on_level_up(new_level: int) -> void:
	level_label.text = "Lv.%d" % new_level
	level_up_popup.show_level_up(new_level)
	_refresh_exp()

func _refresh_exp() -> void:
	exp_bar.max_value = GameManager.exp_to_next()
	exp_bar.value = GameManager.exp
	level_label.text = "Lv.%d" % GameManager.level

func show_boss_alert() -> void:
	boss_alert.visible = true
	floor_label.text = "Floor  %d  !! BOSS" % GameManager.current_floor
	var tween = create_tween()
	tween.tween_property(boss_alert, "modulate:a", 1.0, 0.3)
	tween.tween_interval(2.5)
	tween.tween_property(boss_alert, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func(): boss_alert.visible = false)

func show_theme_enter(theme_name: String, color: Color) -> void:
	var lbl = Label.new()
	lbl.text = "~ %s ~" % theme_name.to_upper()
	lbl.add_theme_font_size_override("font_size", 28)
	lbl.modulate = color
	lbl.modulate.a = 0.0
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.set_anchors_preset(Control.PRESET_CENTER)
	lbl.position += Vector2(-200, -60)
	lbl.size = Vector2(400, 60)
	add_child(lbl)
	var tween = lbl.create_tween()
	tween.tween_property(lbl, "modulate:a", 1.0, 0.5)
	tween.tween_interval(2.0)
	tween.tween_property(lbl, "modulate:a", 0.0, 0.6)
	tween.tween_callback(lbl.queue_free)

func show_perfect_bonus(bonus: int) -> void:
	var lbl = Label.new()
	lbl.text = "PERFECT! +%d" % bonus
	lbl.add_theme_font_size_override("font_size", 20)
	lbl.modulate = Color(1.0, 1.0, 0.2)
	lbl.position = Vector2(80, 170)
	add_child(lbl)
	var tween = lbl.create_tween()
	tween.tween_property(lbl, "position:y", 130.0, 0.4)
	tween.tween_interval(1.5)
	tween.tween_property(lbl, "modulate:a", 0.0, 0.4)
	tween.tween_callback(lbl.queue_free)

func show_floor_clear(floor_num: int) -> void:
	var lbl = Label.new()
	lbl.text = "FLOOR %d CLEARED!" % floor_num
	lbl.add_theme_font_size_override("font_size", 22)
	lbl.modulate = Color(0.4, 1.0, 0.5)
	lbl.position = Vector2(80, 200)
	add_child(lbl)
	var tween = lbl.create_tween()
	tween.tween_property(lbl, "position:y", 160.0, 0.4)
	tween.tween_interval(1.2)
	tween.tween_property(lbl, "modulate:a", 0.0, 0.5)
	tween.tween_callback(lbl.queue_free)

func show_weapon_pickup(weapon_name: String) -> void:
	weapon_label.text = "장착: %s" % weapon_name
	weapon_label.modulate.a = 1.0
	weapon_label.visible = true
	var tween = create_tween()
	tween.tween_interval(1.5)
	tween.tween_property(weapon_label, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func(): weapon_label.visible = false)
