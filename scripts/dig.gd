extends Node2D

onready var player = get_node("/root/main/player")
export var item = ""
export var image = ""
export var hint = ""
onready var hints = get_node("/root/main/UI/hints")

var takeable = true
var activated = false

func _activate():
	if takeable:
		$StaticBody2D/Sprite.visible = true
		$StaticBody2D.collision_layer = 2
		$StaticBody2D.collision_mask = 2
		activated = true

func _act():
	if player.inventory[player.ia] == "shovel":
		hints._write(hint)
		player._pickup(item, image)
		$StaticBody2D/Sprite.visible = false
		$StaticBody2D/Sprite2.visible = true
		$StaticBody2D.collision_layer = 4
		$StaticBody2D.collision_mask = 4
		takeable = false

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
