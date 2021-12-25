extends StaticBody2D

var player
var hints
var item = "timer"
var image = "res://assets/items/timer.png"

func _setup():
	pass

func _act():
	hints.text = ("It's locked...")
	if player.inventory[player.ia] == "key":
		player._erase()
		player._pickup(item, image)
		$Sprite.frame += 1
		get_parent()._no_take()
		hints.text = ("looks like a part of some device?")
