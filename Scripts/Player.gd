extends CharacterBody2D

var speedattack = 1.0
var speedanimation
var speedplayer = 3.0
var time_ls = 0.0
var move = true
var fight = true

var healthpl = 100
var damage_pl = 10
var skin_wea

func _process(delta):
	time_ls += delta

func _physics_process(delta):
	if fight and (Input.is_action_just_pressed("shoot") or Input.is_action_pressed("shoot")):
		shoot()
	
	if move:
		move_character(delta)
	update_shader()
	move_and_slide()

func move_character(delta):
	var movement = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized() * speedplayer
	var node_to_move = $Node2D/Body 
	$".".global_position += movement
	update_character_direction(movement)
	update_wea_rotation(movement)
	if movement.y != 0 or movement.x != 0:
		update_eye_position_and_visibility(movement)
	var parent = node_to_move.get_parent()
	if (movement.y < 0 and node_to_move.get_index() == 0) or (movement.y > 0 and node_to_move.get_index() != 0):
		parent.move_child(node_to_move, 1 - node_to_move.get_index())

func update_character_direction(movement: Vector2):
	if movement.x < 0:
		$Node2D.scale.x = -abs($Node2D/Body.scale.x)
	elif movement.x > 0:
		$Node2D.scale.x = abs($Node2D/Body.scale.x)

func update_wea_rotation(movement: Vector2):
	$Node2D/Wea.rotation_degrees = 90 * sign(movement.y)
	if movement.x != 0:
		$Node2D/Wea.rotation_degrees -= 45 * sign(movement.y)

func update_eye_position_and_visibility(movement: Vector2):
	$Node2D/Body/Eyes.visible = movement.y >= 0 
	var x_offset = 75 if movement.y != 0 and movement.x != 0 else (0 if movement.y != 0 else 130)
	$Node2D/Body/Eyes.position.x = x_offset

func update_shader():
	var tex_width = 256
	var tex_height = 256
	var node_a = $Node2D.position
	var node_b = $Node2D/Body/Eyes.position
	var difference = node_a - node_b
	var shader_material = $Node2D/Body/Eyes.material
	shader_material.set_shader_parameter("mask_position", difference / Vector2(tex_width * 2, tex_height * 2))

func shoot():
	if move:
		fight = false
		move = false
		$WeaponMove.play("1lvl")

func takedamage(damage_en):
	healthpl = healthpl - damage_en
	if healthpl <= 0:
		queue_free()

func _on_weapon_move_animation_finished(anim_name):
	if (Input.is_action_just_pressed("shoot") or Input.is_action_pressed("shoot")):
		fight = true
	else:
		move = true
		fight = true


func _on_area_2d_body_entered(body):
		if body.is_in_group("Weapon"):
			body.Death()
