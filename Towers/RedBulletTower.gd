extends StaticBody2D


var Bullet = preload("res://Towers/RedBullet.tscn")
var bullet_damage = 5
var path_name
var curr_targets = []
var curr


func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()


func _on_tower_body_entered(body):
	if "SoldierA" in body.name:
		var temp_array = []
		curr_targets = get_node("Tower").get_overlapping_bodies()
		
		for target in curr_targets:
			if "Soldier" in target.name:
				temp_array.append(target)
				
		var curr_target = null
		
		for soldier in temp_array:
			if curr_target == null:
				curr_target = soldier.get_node("../")
			else:
				if soldier.get_parent().get_progress() > curr_target.get_progress():
					curr_target = soldier.get_node("../")
		
		curr = curr_target
		path_name = curr_target.get_parent().name
		
		var temp_bullet = Bullet.instantiate()
		temp_bullet.path_name = path_name
		temp_bullet.bullet_damage = bullet_damage
		get_node("BulletContainer").add_child(temp_bullet)
		temp_bullet.global_position = $Aim.global_position
		
		
func _on_tower_body_exited(body):
	curr_targets = get_node("Tower").get_overlapping_bodies()


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Main/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-572, 81)
		
