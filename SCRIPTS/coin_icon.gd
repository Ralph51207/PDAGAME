extends TextureRect

func _ready():
	modulate.a = 0.0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.3)  # fade in
