extends Node2D

onready var player = get_node("/root/main/player")
var item = "light"
var image = "res://assets/light.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	if player.inventory[player.ia] == "coin":
		player._erase()
		player._pickup(item, image)
		hints._write("This vending machine sells flashlights?")
	else:
		hints._write("No money, no vending")
