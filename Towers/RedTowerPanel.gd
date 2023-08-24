extends Panel

@onready var tower = preload("res://Towers/RedBulletTower.tscn")
var curr_tile

func _on_gui_input(event):
	var temp_tower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#left click down
		add_child(temp_tower)
		temp_tower.process_mode = Node.PROCESS_MODE_DISABLED
	elif event is InputEventMouseMotion and event.button_mask == 1:
		# left click down drag
		get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		# left click up
		print("left button up")
		
