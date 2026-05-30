extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var floor_label: Label = $FloorLabel
@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	GameManager.floor_cleared.connect(_on_floor_changed)

func update_health(current: int, maximum: int) -> void:
	health_bar.max_value = maximum
	health_bar.value = current

func _on_floor_changed() -> void:
	floor_label.text = "Floor: %d" % GameManager.current_floor
	score_label.text = "Score: %d" % GameManager.score
