extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var exp_bar: ProgressBar = $ExpBar
@onready var floor_label: Label = $FloorLabel
@onready var score_label: Label = $ScoreLabel
@onready var level_label: Label = $LevelLabel
@onready var boss_alert: Label = $BossAlert
@onready var weapon_label: Label = $WeaponLabel
@onready var minimap: Control = $Minimap
@onready var level_up_popup: CanvasLayer = $LevelUpPopup

func _ready() -> void:
	GameManager.level_up.connect(_on_level_up)
	_refresh_exp()

func update_health(current: int, maximum: int) -> void:
	health_bar.max_value = maximum
	health_bar.value = current

func update_floor(floor_num: int) -> void:
	floor_label.text = "Floor: %d" % floor_num

func update_score(s: int) -> void:
	score_label.text = "Score: %d" % s
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
	floor_label.text = "Floor: %d  !! BOSS" % GameManager.current_floor
	var tween = create_tween()
	tween.tween_interval(3.0)
	tween.tween_callback(func(): boss_alert.visible = false)

func show_weapon_pickup(weapon_name: String) -> void:
	weapon_label.text = "장착: %s" % weapon_name
	weapon_label.visible = true
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(func(): weapon_label.visible = false)
