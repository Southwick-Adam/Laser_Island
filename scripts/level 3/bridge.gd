extends Node2D

export (PackedScene) var Time

onready var player = get_node("/root/main/player")
onready var hints = get_node("/root/main/UI/hints/Label")

var phase = 0

var takeable = true

func _act():
	if phase == 0:
		hints.text = ("Too damaged to cross")
	else:
		hints.text = ("I need something to fasten these planks")
	if player.inventory[player.ia] == "wood" and phase == 0:
		$body/Sprite2.visible = true
		player._erase()
		phase += 1
		hints.text = ("Just the right size!")
	elif player.inventory[player.ia] == "nails" and phase == 1:
		$body/Sprite2.visible = false
		player._erase()
		$body/TileMap.set_cell(0,0,1)
		$body.collision_layer = 2
		$body.collision_mask = 2
		takeable = false
		$body/glow.modulate.a = 0
		hints.text = ("Fixed it!")

func _on_AnimationPlayer_animation_finished(_anim_name):
	var node = Time.instance()
	get_node("/root/main").call_deferred("add_child", node)

func _on_AnimationPlayer_animation_started(anim):
	if anim == ("burn"):
		var map = get_node("/root/main/world/level/TileMap")
		map.set_cell(3,7,17)
		map.set_cell(6,7,21)

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()

func _glow(boo):
	$body/glow.visible = boo

func _death():
	$AnimationPlayer.play("burn")

func _no_take():
	takeable = false
	$body/glow.self_modulate.a = 0
