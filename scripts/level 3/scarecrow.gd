extends StaticBody2D

var player
var hints
var item = "coin"
var image = "res://assets/items/coin.png"
var phase = ["c","t"]

func _setup():
	pass

func _act():
	hints.text = "nothing interesting left on him"
	if player.inventory[player.ia] == "axe":
		hints.text = "nothing else worth chopping"
		if phase.has("t"):
			hints.text = "off with his... turnip i guess"
			item = "turnip"
			image = "res://assets/items/turnip.png"
			player._pickup(item, image)
			$Sprite.frame += 1
			$glow.frame += 1
			phase.erase("t")
	else:
		if phase.has("c"):
			hints.text = "He has a coin in his pocket. mine now"
			item = "coin"
			image = "res://assets/items/coin.png"
			player._pickup(item, image)
			phase.erase("c")
		elif phase.has("t"):
			hints.text = "that turnip head looks kinda tasty though"
	if not (phase.has("c") or phase.has("t")):
		get_parent()._no_take()
