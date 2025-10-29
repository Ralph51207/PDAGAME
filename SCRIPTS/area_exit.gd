extends Area2D

@export var sprite: Sprite2D
var is_open := false

func _ready() -> void:
	close_portal()

func open_portal() -> void:
	is_open = true
	if sprite and sprite.region_enabled:
		sprite.region_rect = Rect2(Vector2(64, 0), Vector2(64, 64))
		sprite.queue_redraw()
	print("🚪 Portal opened!")

func close_portal() -> void:
	is_open = false
	if sprite and sprite.region_enabled:
		sprite.region_rect = Rect2(Vector2(0, 0), Vector2(64, 64))
		sprite.queue_redraw()
	print("🚪 Portal closed!")

func _on_body_entered(body: Node2D) -> void:
	if is_open and body is PlayerController:
		Gamemanager.next_level()
