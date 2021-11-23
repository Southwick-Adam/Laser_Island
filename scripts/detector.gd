extends Node2D

onready var player = get_node("/root/main/player")
var item = "detector"
var image = "res://assets/metdet.png"

var takeable = true

func _act():
	player._pickup(item, image)
	$StaticBody2D/Sprite.visible = false
	takeable = false
