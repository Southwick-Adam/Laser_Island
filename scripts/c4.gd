extends Node2D

onready var player = get_node("/root/main/player")
var item = "c4"
var image = "res://assets/c4.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	player._pickup(item, image)
	$StaticBody2D/Sprite.visible = false
	$StaticBody2D.collision_layer = 2
	$StaticBody2D.collision_mask = 2
	$StaticBody2D/Sprite2.z_index = -1
	takeable = false
	hints._write("not much boom without a detonator")

