extends StaticBody2D


var Bullet = preload("res://Towers/RedBullet.gd")
var bullet_damage = 5
var path_name
var curr_targets = []
var curr



func _on_tower_body_entered(body):
	if "SoldierA" in body.name:
		pass


func _on_tower_body_exited(body):
	pass # Replace with function body.
