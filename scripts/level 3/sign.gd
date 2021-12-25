extends StaticBody2D

var player
var hints
var item = "nails"
var image = "res://assets/items/nail.png"

var dig = true

func _setup():
	pass

func _act():
	if player.inventory[player.ia] == "axe":
		player._pickup(item, image)
		collision_layer = 2
		collision_mask = 2
		$Sprite2.z_index = -1
		get_parent()._no_take()
		$Sprite.visible = false
		hints.text = ("Everyone needs nails... probably")
	else:
		if dig:
			hints.text = ("Sign says there's something buried there")
			get_node("/root/main/world/level/dig/body")._activate()
			dig = false
		else:
			hints.text = ("just an old rotten board and some nails")
