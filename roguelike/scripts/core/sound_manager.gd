extends Node

# AudioStreamGenerator로 효과음 프로그래밍 생성 (외부 파일 불필요)
# Godot 4 WebGL에서 지원됨

const SAMPLE_RATE = 22050.0

static func _make_player(duration: float) -> AudioStreamPlayer:
	var stream = AudioStreamGenerator.new()
	stream.mix_rate = SAMPLE_RATE
	stream.buffer_length = duration + 0.05
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = -6.0
	return player

static func play_hit(parent: Node) -> void:
	_play_tone(parent, 220.0, 0.08, "square", -14.0)

static func play_attack(parent: Node) -> void:
	_play_tone(parent, 440.0, 0.06, "saw", -10.0)

static func play_level_up(parent: Node) -> void:
	_play_chord(parent, [523.0, 659.0, 784.0], 0.3)

static func play_item(parent: Node) -> void:
	_play_tone(parent, 880.0, 0.12, "sine", -8.0)

static func play_boss_alert(parent: Node) -> void:
	_play_tone(parent, 110.0, 0.4, "square", -6.0)

static func _play_tone(parent: Node, freq: float, duration: float, wave: String, vol_db: float) -> void:
	var player = _make_player(duration)
	player.volume_db = vol_db
	parent.add_child(player)
	player.play()
	var pb = player.get_stream_playback()
	var frames = int(SAMPLE_RATE * duration)
	for i in range(frames):
		var t = float(i) / SAMPLE_RATE
		var env = 1.0 - (float(i) / frames)  # 선형 감쇠
		var s: float
		match wave:
			"sine":   s = sin(TAU * freq * t)
			"square": s = 1.0 if fmod(freq * t, 1.0) < 0.5 else -1.0
			"saw":    s = 2.0 * fmod(freq * t, 1.0) - 1.0
			_:        s = sin(TAU * freq * t)
		pb.push_frame(Vector2(s * env, s * env))
	# 자동 정리
	var timer = parent.get_tree().create_timer(duration + 0.1)
	timer.timeout.connect(player.queue_free)

static func _play_chord(parent: Node, freqs: Array, duration: float) -> void:
	for f in freqs:
		_play_tone(parent, f, duration, "sine", -14.0)
