extends Node2D

onready var player = get_node("/root/main/player")
var item = "shovel"
var image = "res://assets/shovel.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	hints._write("Good for digging")
	player._pickup(item, image)
	$StaticBody2D/Sprite.visible = false
	$StaticBody2D.collision_layer = 2
	$StaticBody2D.collision_mask = 2
	$StaticBody2D/Sprite2.z_index = -1
	takeable = false

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
