extends Node2D

onready var player = get_node("/root/main/player")
var item = "juice"
var image = "res://assets/juice.png"
onready var hints = get_node("/root/main/UI/hints")
var takeable = true
var phase = 0

func _act():
	hints._write("juice makes you strong, guaranteed!")
	if phase == 0:
		if player.inventory[player.ia] == "turnip":
			player._erase()
			phase += 1
			$StaticBody2D/Sprite.frame += 1
			hints._write("brrrrrr")
	else:
		if player.inventory[player.ia] == "cup":
			player._erase()
			player._pickup(item, image)
			$StaticBody2D/Sprite.frame -= 1
			takeable = false
			hints._write("Looks refreshing!")

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
