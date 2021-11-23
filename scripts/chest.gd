extends Node2D

onready var player = get_node("/root/main/player")
var item = "timer"
var image = "res://assets/timer.png"
onready var hints = get_node("/root/main/UI/hints")
var takeable = true

func _act():
	hints._write("It's locked...")
	if player.inventory[player.ia] == "key":
		player._erase()
		player._pickup(item, image)
		$StaticBody2D/Sprite.frame += 1
		takeable = false
		hints._write("looks like a part of some device?")

func _process(_delta):
	$StaticBody2D/Sprite2.self_modulate = $StaticBody2D/Sprite.self_modulate
