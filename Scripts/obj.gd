extends CharacterBody2D

var item = preload("res://Scenes/item.tscn")

func _physics_process(delta):
	pass

func _on_animated_sprite_2d_animation_finished():
	spawn_object(item)
	queue_free()

func Death():
	$Death.play("Boom")

func spawn_object(prefab):
	var instance = prefab.instantiate()
	get_parent().add_child(instance)
	instance.global_position = global_position 
