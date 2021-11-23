extends Node2D

export (PackedScene) var Time

onready var player = get_node("/root/main/player")
onready var hints = get_node("/root/main/UI/hints")

var phase = 0

var takeable = true

func _act():
	if phase == 0:
		hints._write("Too damaged to cross")
	else:
		hints._write("I need something to fasten these planks")
	if player.inventory[player.ia] == "wood" and phase == 0:
		$StaticBody2D/Sprite2.visible = true
		player._erase()
		phase += 1
		hints._write("Just the right size!")
	elif player.inventory[player.ia] == "nails" and phase == 1:
		$StaticBody2D/Sprite2.visible = false
		player._erase()
		$StaticBody2D/Sprite.frame -= 1
		$StaticBody2D.collision_layer = 2
		$StaticBody2D.collision_mask = 2
		takeable = false
		hints._write("Fixed it!")

func _on_AnimationPlayer_animation_finished(_anim_name):
	var node = Time.instance()
	get_node("/root/main").call_deferred("add_child", node)

func _on_AnimationPlayer_animation_started(anim):
	if anim == ("burn"):
		var map = get_node("/root/main/world/TileMap")
		map.set_cell(3,7,16)
		map.set_cell(6,7,15)
