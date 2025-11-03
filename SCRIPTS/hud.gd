extends CanvasLayer

@export var coin_container: Container
@export var coin_icon_scene: PackedScene
@export var coin_label: Label
@export var portal_label: Label

var coin_stack: Array = []


func _ready() -> void:
	if coin_container == null:
		coin_container = get_node_or_null("coin_container") as Container
		if coin_container == null:
			for c in get_children():
				if c is Container:
					coin_container = c
					break

	if coin_label == null:
		coin_label = get_node_or_null("coin_label") as Label

	if portal_label == null:
		portal_label = get_node_or_null("portal_label") as Label

	update_portal(false)
	_update_coin_text()


# 🟢 Push (adds visually at bottom → logically top)
func push_coin() -> void:
	if coin_icon_scene == null:
		push_warning("HUD: coin_icon_scene not set.")
		return

	var coin_instance = coin_icon_scene.instantiate()
	if coin_container == null:
		push_warning("HUD: no container found.")
		return

	# Insert at the *top visually* (index 0), so the new coin appears at the bottom when using VBox flipped
	coin_container.add_child(coin_instance)
	coin_container.move_child(coin_instance, 0)

	coin_stack.append(coin_instance)
	_update_coin_text()


# 🔴 Pop (removes from the visual top, last pushed)
func pop_coin() -> void:
	if coin_stack.is_empty():
		return

	coin_stack.pop_back()

	if coin_container and coin_container.get_child_count() > 0:
		# Remove the bottom-most visually (last child)
		var bottom_coin = coin_container.get_child(coin_container.get_child_count() - 1)
		if is_instance_valid(bottom_coin):
			bottom_coin.queue_free()

	_update_coin_text()


# 🧩 Update text
func _update_coin_text() -> void:
	if coin_label:
		coin_label.text = "Stack: %d" % coin_stack.size()


# 🚪 Portal updates
func update_portal(is_open: bool) -> void:
	if portal_label:
		portal_label.text = "Portal Open!" if is_open else "Portal Closed... Get more coins!"
