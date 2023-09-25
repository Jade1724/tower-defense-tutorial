extends Panel

@onready var tower = preload("res://Towers/RedBulletTower.tscn")
var curr_tile

func _on_gui_input(event):
	if Game.Gold >= 10:
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
				
				var map_path = get_tree().get_root().get_node("Main/TileMap")
				var tile = map_path.local_to_map(get_global_mouse_position())
				curr_tile = map_path.get_cell_atlas_coords(0, tile, false)
				var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
				if curr_tile == Vector2i(4, 5):
					if (targets.size() > 0):
						get_child(1).get_node("Area").modulate = Color(255, 255, 255, 0.3)
					else:
						get_child(1).get_node("Area").modulate = Color(0, 255, 0, 0.3)
				else:
					get_child(1).get_node("Area").modulate = Color(255, 255, 255, 0.3)
				
		elif event is InputEventMouseButton and event.button_mask == 0:
			# left click up
			if get_child_count() > 1:
				get_child(1).queue_free()
			if event.global_position.x * 3 <= 2944:
				if curr_tile == Vector2i(4, 5):
					var path = get_tree().get_root().get_node("Main/Towers")
					var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
					if (targets.size() < 1):
						path.add_child(temp_tower)
						temp_tower.global_position = event.global_position * 3
						temp_tower.get_node("Area").hide()
						Game.Gold -= 10
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
