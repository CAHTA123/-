extends Sprite2D
var mouse

func _ready():
	mouse = $"."

func _process(delta):
	mouse.global_position = get_global_mouse_position()
