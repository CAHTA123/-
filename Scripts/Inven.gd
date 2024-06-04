extends Control

var is_open = false

func _ready():
	close()

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func close():
	is_open = false
	visible = false

func open():
	is_open = true
	visible = true




var items: Array = []

signal inventory_updated(item_list)

func add_item(item: Item) -> void:
	items.append(item)
	emit_signal("inventory_updated", items)
	update_ui()

func remove_item(item: Item) -> void:
	items.erase(item)
	emit_signal("inventory_updated", items)
	update_ui()

func update_ui() -> void:
	for i in range($SlotsContainer.get_child_count()):
		var slot = $SlotsContainer.get_child(i)
		if i < items.size():
			slot.update_slot(items[i])
		else:
			slot.clear_slot()
