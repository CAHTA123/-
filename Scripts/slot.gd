extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var item: Item = null

func update_slot(new_item: Item) -> void:
	item = new_item
	$Icon.texture = new_item.icon if new_item.icon else preload("res://Sprites/GameInterface/Slot.png")
	$Quantity.text = str(new_item.quantity)
	self.visible = true

func clear_slot() -> void:
	item = null
	$Icon.texture = preload("res://Sprites/GameInterface/Slot.png")
	$Quantity.text = ""
	self.visible = false  # или true в зависимости от вашего дизайна
