extends StaticBody2D

var player
var hints
var item = "detector"
var image = "res://assets/items/detector.png"
var dig_sites

func _setup():
	dig_sites = get_parent().get_parent().get_node("digsites").get_child_count()

func _act():
	player._pickup(item, image)
	$Sprite.visible = false
	get_parent()._no_take()
	collision_layer = 2
	collision_mask = 2
	set_process(true)

func _process(_delta):
	if player.inventory[player.ia] == "detector" and dig_sites > 0:
		hints.text = (str(dig_sites) + " more dig sites detected")
		for site in get_parent().get_parent().get_node("digsites").get_children():
			var dig_pos = site.global_position
			if (player.get_child(0).global_position - dig_pos).length() < 85 and not site.get_node("body").activated:
				site.get_node("body")._activate()
				dig_sites -= 1
