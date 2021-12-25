extends StaticBody2D

var player
var hints
var item = "c4"
var image = "res://assets/items/c4.png"

func _setup():
	pass

func _act():
	player._pickup(item, image)
	$Sprite.visible = false
	collision_layer = 2
	collision_mask = 2
	$Sprite2.z_index = -1
	get_parent()._no_take()
	hints.text = ("not much boom without a detonator")
