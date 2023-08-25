extends Panel

@onready var tower = preload("res://Towers/RedBulletTower.tscn")
var curr_tile

func _on_gui_input(event):
	var temp_tower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#left click down
		add_child(temp_tower)
		temp_tower.process_mode = Node.PROCESS_MODE_DISABLED
		temp_tower.scale = Vector2(0.32, 0.32)
	elif event is InputEventMouseMotion and event.button_mask == 1:
		# left click down drag
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
				
	elif event is InputEventMouseButton and event.button_mask == 0:
		# left click up
		if get_child_count() > 1:
				get_child(1).queue_free()
		if event.global_position.x * 3 <= 2944:
			var path = get_tree().get_root().get_node("Main/Towers")
			path.add_child(temp_tower)
			temp_tower.global_position = event.global_position * 3
			temp_tower.get_node("Area").hide()
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
