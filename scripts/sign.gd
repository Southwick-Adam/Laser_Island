extends Node2D

onready var player = get_node("/root/main/player")
var item = "nails"
var image = "res://assets/nail.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true
var dig = true

func _act():
	if player.inventory[player.ia] == "axe":
		player._pickup(item, image)
		$StaticBody2D.collision_layer = 2
		$StaticBody2D.collision_mask = 2
		$StaticBody2D/Sprite2.z_index = -1
		takeable = false
		$StaticBody2D/Sprite.visible = false
		hints._write("Everyone needs nails... probably")
	else:
		if dig:
			hints._write("Sign says there's something buried there")
			get_node("/root/main/digs/dig")._activate()
			dig = false
		else:
			hints._write("just an old rotten board and some nails")

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
