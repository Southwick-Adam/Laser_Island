extends StaticBody2D

var player
var hints
var item = "axe"
var image = "res://assets/items/axe.png"

func _setup():
	$Sprite.rotation_degrees = 90
	$glow.rotation_degrees = 90

func _act():
	hints.text = "Looks very sharp!"
	player._pickup(item, image)
	$Sprite.visible = false
	collision_layer = 2
	collision_mask = 2
	get_parent()._no_take()
