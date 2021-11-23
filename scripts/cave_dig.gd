extends Node2D

onready var player = get_node("/root/main/player")
var item = "wires"
var image = "res://assets/wires.png"
onready var hints = get_node("/root/main/UI/hints")

var phase = 0

var takeable = true
var activated = false

func _activate():
	if takeable:
		$StaticBody2D/Sprite.visible = true
		$StaticBody2D.collision_layer = 1
		$StaticBody2D.collision_mask = 1
		activated = true

func _act():
	if phase == 1:
		hints._write("Too dark to see what's in there")
	if player.inventory[player.ia] == "shovel" and phase == 0:
		$StaticBody2D/Sprite.visible = false
		$StaticBody2D/Sprite2.visible = true
		phase += 1
		hints._write("looks like there's a cave under here. Dark though...")
	elif player.inventory[player.ia] == "light" and phase == 1:
		player._pickup(item, image)
		takeable = false
		hints._write("you need wires to build most things i bet")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "burn":
		activated = true
