extends StaticBody2D

var player
var hints

func _setup():
	$CollisionShape2D.scale.x += 0.8

func _act():
	hints.text = ("This rock is heavy. if only i were stronger")
	if player.inventory[player.ia] == "juice":
		hints.text = ("It's not so bad with some Vitamin c in me")
		player._erase()
		var loc = get_node("/root/main/world/level/rock_pos").global_position
		get_parent().global_position = loc
		get_parent()._no_take()
		get_node("/root/main/world/level/grass").queue_free()
		get_node("/root/main/world/level/grass2").visible = true
