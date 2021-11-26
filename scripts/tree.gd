extends Node2D

onready var player = get_node("/root/main/player")
var item = "wood"
var image = "res://assets/wood.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	hints._write("a fine old tree")
	if player.inventory[player.ia] == "axe":
		hints._write("Chop chop")
		player._pickup(item, image)
		takeable = false
		$StaticBody2D/Sprite.frame += 1
		$StaticBody2D/CollisionShape2D.position.y = 37
		$StaticBody2D/CollisionShape2D.shape.extents.y = 23
		$Area2D.position.y = 25

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
