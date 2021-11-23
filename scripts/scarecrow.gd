extends Node2D

onready var player = get_node("/root/main/player")
var item = "coin"
var image = "res://assets/coin.png"
onready var hints = get_node("/root/main/UI/hints")

var phase = ["c","t"]
var takeable = true

func _act():
	hints._write("nothing interesting left on him")
	if player.inventory[player.ia] == "axe":
		hints._write("nothing else worth chopping")
		if phase.has("t"):
			hints._write("off with his... turnip i guess")
			item = "turnip"
			image = "res://assets/turnip.png"
			player._pickup(item, image)
			$StaticBody2D/Sprite.texture = load("res://assets/frame.png")
			phase.erase("t")
	else:
		if phase.has("c"):
			hints._write("He has a coin in his pocket. mine now")
			item = "coin"
			image = "res://assets/coin.png"
			player._pickup(item, image)
			phase.erase("c")
		elif phase.has("t"):
			hints._write("that turnip head looks kinda tasty though")
