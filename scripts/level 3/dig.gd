extends StaticBody2D

var player
var hints
var item = "cup"
var image = "res://assets/items/cup.png"
var hint = "an empty cup. isn't this just trash?"

var activated = false

func _setup():
	$Sprite2.visible = false
	$Sprite.visible = false
	$glow.modulate.a = 0
	collision_layer = 2
	collision_mask = 2
	z_index -= 3

func _activate():
	$glow.modulate.a = 1
	$Sprite.visible = true
	activated = true
	if get_parent().name == "digsite":
		item = "key"
		image = "res://assets/items/key.png"
		hint = "a fancy key"

func _act():
	if player.inventory[player.ia] == "shovel" and activated:
		hints.text = (hint)
		player._pickup(item, image)
		$Sprite.texture = load("res://assets/items/hole.png")
		collision_layer = 4
		collision_mask = 4
