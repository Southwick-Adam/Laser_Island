extends StaticBody2D

var player
var hints
var item = "juice"
var image = "res://assets/items/juice.png"

var phase = 0

func _setup():
	$CollisionShape2D.scale.x += 0.3

func _act():
	hints.text = ("juice makes you strong, guaranteed!")
	if phase == 0:
		if player.inventory[player.ia] == "turnip":
			player._erase()
			phase += 1
			$Sprite.frame += 1
			hints.text = ("blender noises")
	else:
		if player.inventory[player.ia] == "cup":
			player._erase()
			player._pickup(item, image)
			$Sprite.frame -= 1
			get_parent()._no_take()
			hints.text = ("Looks refreshing!")
