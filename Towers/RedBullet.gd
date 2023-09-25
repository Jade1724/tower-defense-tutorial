extends CharacterBody2D


var target
var SPEED = 1000
var path_name = ""
var bullet_damage

func _physics_process(delta):
	var path_spawner_node = get_tree().get_root().get_node("Main/PathSpawner")
	
	for path in path_spawner_node.get_child_count():
		if path_spawner_node.get_child(path).name == path_name:
			target = path_spawner_node.get_child(path).get_child(0).get_child(0).global_position
	
	if (target):
		velocity = global_position.direction_to(target)*SPEED
		look_at(target)
		move_and_slide()
	else:
		queue_free()
	

func _on_area_2d_body_entered(body):
	if "Soldier" in body.name:
		body.health -= bullet_damage
		queue_free()
