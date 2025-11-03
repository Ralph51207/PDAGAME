extends Path2D
class_name MovingPlatform

@export var path_time: float = 1.0
@export var ease: Tween.EaseType = Tween.EASE_IN_OUT
@export var transition: Tween.TransitionType = Tween.TRANS_SINE
@export var looping: bool = false  # 🔁 toggle for looping

var path_follow_2d: PathFollow2D

func _ready():
	# 🩵 Duplicate the curve so each platform has its own unique copy
	if curve:
		curve = curve.duplicate()
	
	path_follow_2d = $PathFollow2D
	move_tween()

func move_tween():
	var tween = get_tree().create_tween()
	if looping:
		tween.set_loops()

	# Move forward
	tween.tween_property(path_follow_2d, "progress_ratio", 1.0, path_time)\
		.set_trans(transition).set_ease(ease)

	# Move backward if looping
	if looping:
		tween.tween_property(path_follow_2d, "progress_ratio", 0.0, path_time)\
			.set_trans(transition).set_ease(ease)
