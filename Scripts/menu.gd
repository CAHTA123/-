extends Node

const SCREEN_CENTER = Vector2(960, 540)

var destination = Vector2()
var destination2 = Vector2()

var textures = [] 
var current_texture_index = 0 
var But
var BG 
var BG2 
var acceleration = 100
var can = false
var can2 = false

var candy = false
var candy2 = false

var speed = 20
var speed2 = 20
var start = Vector2()


func _ready():
	randomize()
	
	textures.append(load("res://Sprites/Menu/BG.png"))
	textures.append(load("res://Sprites/Menu/BG2.png"))
	textures.append(load("res://Sprites/Menu/BG3.png"))
	textures.append(load("res://Sprites/Menu/BG4.png"))
	
	set_initial_conditions()
	
func set_initial_conditions():
	BG = $"xxx/1/Bg"
	BG2 = $"xxx/1/Bg2"
	But = $"xxx/1/Buttons"
	BG.modulate.a = 0
	BG2.modulate.a = 0
	destination = random_position()
	BG.global_position = SCREEN_CENTER + (SCREEN_CENTER - destination)
	can = true
	BG.texture = textures[current_texture_index]
func _process(delta):
	if But.modulate.a < 1:
			But.modulate.a += delta
	if can:
		move_bg(BG, destination, delta, can)
	if can2:
		move_bg1(BG2, destination2, delta, can2)


func move_bg(bg, dest, delta, cans):
	var distance = bg.global_position.distance_to(dest)
	if distance >= 5:
		candy = true
		if bg.modulate.a < 1:
			bg.modulate.a += delta
		bg.global_position += (dest - bg.global_position).normalized() * speed * delta
	else:
		if bg.modulate.a > 0.1:
			speed -= acceleration * delta
			bg.modulate.a -= delta
			if candy:
				swap_backgrounds(bg)
				candy = false
		else:
			bg.modulate.a = 0
			cans = false

func move_bg1(bg, dest, delta, cans):
	var distance = bg.global_position.distance_to(dest)
	if distance >= 5:
		candy2 = true
		if bg.modulate.a < 1:
			bg.modulate.a += delta
		bg.global_position += (dest - bg.global_position).normalized() * speed2 * delta
	else:
		if bg.modulate.a > 0.1:
			speed2 -= acceleration * delta
			bg.modulate.a -= delta
			if candy2:
				swap_backgrounds(bg)
				candy2 = false
		else:
			bg.modulate.a = 0
			cans = false

func swap_backgrounds(bg):
	if bg == BG2:
		current_texture_index = (current_texture_index + 1) % textures.size()
		BG.texture = textures[current_texture_index]
		destination = random_position()
		BG.global_position = SCREEN_CENTER + (SCREEN_CENTER - destination)
		speed = 20
		can = true
	else:
		current_texture_index = (current_texture_index + 1) % textures.size()
		BG2.texture = textures[current_texture_index]
		destination2 = random_position()
		BG2.global_position = SCREEN_CENTER + (SCREEN_CENTER - destination2)
		speed2 = 20
		can2 = true

func random_position():
	var side = randi() % 4 
	var pos_x = 0
	var pos_y = 0  
	var cel
	match side:
		0:  
			pos_x = randf_range(880, 1040)
			pos_y = 500
		1:  
			pos_x = randf_range(880, 1040)
			pos_y = 580
		2:  
			pos_x = 880
			pos_y = randf_range(500, 580)
		3:  
			pos_x = 1040
			pos_y = randf_range(500, 580)    
	cel = Vector2(pos_x, pos_y)
	return cel
	
	
	
	
	
	
	
	

func _on_texture_button_mouse_entered():
	$TextureButton.scale.x = 0.4
	$TextureButton.scale.y = 0.4

func _on_texture_button_mouse_exited():
	$TextureButton.scale.x = 0.2
	$TextureButton.scale.y = 0.2


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_exit_pressed():
	get_tree().quit() 

func _on_settings_pressed():
	$Settings.visible = true
	$Sprite2D.visible = true
	$"xxx/1/Buttons".visible = false

func _on_play_mouse_entered():
	$"xxx/1/Buttons/Play/Play2".scale.x = 0.35
	$"xxx/1/Buttons/Play/Play2".scale.y = 0.35

func _on_play_mouse_exited():
	$"xxx/1/Buttons/Play/Play2".scale.x = 0.3
	$"xxx/1/Buttons/Play/Play2".scale.y = 0.3


func _on_settings_mouse_entered():
	$"xxx/1/Buttons/Settings/Settings2".scale.x = 0.35
	$"xxx/1/Buttons/Settings/Settings2".scale.y = 0.35


func _on_settings_mouse_exited():
	$"xxx/1/Buttons/Settings/Settings2".scale.x = 0.3
	$"xxx/1/Buttons/Settings/Settings2".scale.y = 0.3
	
func _on_exit_mouse_entered():
	$"xxx/1/Buttons/Exit/Exit2".scale.x = 0.35
	$"xxx/1/Buttons/Exit/Exit2".scale.y = 0.35


func _on_exit_mouse_exited():
	$"xxx/1/Buttons/Exit/Exit2".scale.x = 0.3
	$"xxx/1/Buttons/Exit/Exit2".scale.y = 0.3


func _on_button_pressed():
	$Settings.visible = false
	$Sprite2D.visible = false
	$"xxx/1/Buttons".visible = true
