extends StaticBody2D

var player
var hints
var item = "shovel"
var image = "res://assets/items/shovel.png"

func _setup():
	pass

func _act():
	hints.text = ("Good for digging")
	player._pickup(item, image)
	$Sprite.visible = false
	collision_layer = 2
	collision_mask = 2
	$Sprite2.z_index = -1
	get_parent()._no_take()
