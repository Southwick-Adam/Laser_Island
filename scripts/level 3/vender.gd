extends StaticBody2D

var player
var hints
var item = "light"
var image = "res://assets/items/light.png"

func _setup():
	$CollisionShape2D.scale.x += 0.3

func _act():
	if player.inventory[player.ia] == "coin":
		player._erase()
		player._pickup(item, image)
		hints.text = "This vending machine sells flashlights?"
		get_parent()._no_take()
	else:
		hints.text = ("No money, no vending")
