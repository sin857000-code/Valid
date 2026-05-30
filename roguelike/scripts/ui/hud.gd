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

func _ready() -> void:
	GameManager.level_up.connect(_on_level_up)
	_refresh_exp()
	_combo_label = Label.new()
	_combo_label.add_theme_font_size_override("font_size", 18)
	_combo_label.modulate = Color(1.0, 0.8, 0.2, 0.0)
	_combo_label.position = Vector2(8, 130)
	add_child(_combo_label)

func _process(_delta: float) -> void:
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")
		return
	var cd = _player._dash_cooldown_timer
	var ratio = 1.0 - clamp(cd / _player.DASH_COOLDOWN, 0.0, 1.0)
	dash_bar.value = ratio * 100.0
	dash_bar.modulate = Color(0.4, 0.9, 1.0) if ratio >= 1.0 else Color(0.6, 0.6, 0.6)
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
	floor_label.text = "Floor  %d" % floor_num

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

func show_weapon_pickup(weapon_name: String) -> void:
	weapon_label.text = "장착: %s" % weapon_name
	weapon_label.modulate.a = 1.0
	weapon_label.visible = true
	var tween = create_tween()
	tween.tween_interval(1.5)
	tween.tween_property(weapon_label, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func(): weapon_label.visible = false)
