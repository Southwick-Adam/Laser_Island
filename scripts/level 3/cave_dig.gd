extends StaticBody2D

var player
var hints
var item = "wires"
var image = "res://assets/items/wires.png"
var phase = 0

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

func _act():
	if player.inventory[player.ia] == "shovel" and phase == 0 and activated:
		hints.text = "A cave under here. Dark though."
		$Sprite.texture = load("res://assets/items/cave.png")
		$glow.texture = load("res://assets/items/cave.png")
		collision_layer = 1
		collision_mask = 1
		phase += 1
	elif player.inventory[player.ia] == "light" and phase == 1:
		player._pickup(item, image)
		get_parent()._no_take()
