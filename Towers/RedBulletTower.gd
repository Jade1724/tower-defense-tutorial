extends StaticBody2D


var Bullet = preload("res://Towers/RedBullet.tscn")
var bullet_damage = 5
var path_name
var curr_targets = []
var curr



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
	pass # Replace with function body.
