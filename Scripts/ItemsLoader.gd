extends Node

class_name ItemsLoader

var json_file_path = "res://Resourse/items.json"

func _ready():
	var items = load_items()
	for item_id in items.keys():
		print(items[item_id].name)

func load_items():
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		var items_data = JSON.parse_string(content)
		var items = {}
		for item_id in items_data.keys():
			var item_dict = items_data[item_id]
			var icon_path = "res://path/to/icons/" + item_dict["icon"]
			var item = preload("res://Scripts/item.gd").new()
			item.id = item_dict["ID"]
			item.name = item_dict["name"]
			item.description = item_dict["description"]
			item.image = load(icon_path)
			items[item_id] = item
		return items
	return {}
