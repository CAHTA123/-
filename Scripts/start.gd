extends Node2D


func _ready():
	# Запускаем анимацию сразу при запуске сцены
	$AnimationPlayer.play("1")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "1":
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
