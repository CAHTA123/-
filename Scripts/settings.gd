extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_h_slider_value_changed(value):
	var volume_db
	if value == 0:
		volume_db = -80
	elif value == 100:
		volume_db = 10
	else:
		var min_db = -40 if value < 50 else 0
		var max_db = 0 if value < 50 else 10
		var norm_value = value / 50 if value < 50 else (value - 50) / 50
		volume_db = (norm_value * (max_db - min_db)) + min_db
		$"../Audio".set_volume_db(volume_db)

