extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var floor_label: Label = $FloorLabel
@onready var score_label: Label = $ScoreLabel
@onready var minimap: Control = $Minimap

func update_health(current: int, maximum: int) -> void:
	health_bar.max_value = maximum
	health_bar.value = current

func update_floor(floor_num: int) -> void:
	floor_label.text = "Floor: %d" % floor_num

func update_score(s: int) -> void:
	score_label.text = "Score: %d" % s
