extends Node2D

onready var player = get_node("/root/main/player")
var item = "light"
var image = "res://assets/light.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	hints._write("This rock is heavy. if only i were stronger")
	if player.inventory[player.ia] == "juice":
		hints._write("It's not so bad with some Vitamin c in me")
		player._erase()
		var loc = $Position2D.global_position
		global_position = loc
		takeable = false
		get_node("/root/main/grass2").queue_free()
		get_node("/root/main/grass").visible = true
