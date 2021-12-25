extends StaticBody2D

var player
var hints
var item = "wood"
var image = "res://assets/items/wood.png"

func _setup():
	$CollisionShape2D.scale.x += 0.8
	$CollisionShape2D.scale.y += 0.5
	

func _act():
	hints.text = ("a fine old tree")
	if player.inventory[player.ia] == "axe":
		hints.text = ("Chop chop")
		player._pickup(item, image)
		get_parent()._no_take()
		$Sprite.frame += 1
		$CollisionShape2D.position.y = 42
		$CollisionShape2D.scale *= 0.5
		get_parent().get_node("Area2D").position.y = 25
		$Sprite2/shadow.scale *= 0.5
