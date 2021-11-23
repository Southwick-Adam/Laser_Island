extends Node2D

onready var player = get_node("/root/main/player")
var item = "bomb"
var image = "res://assets/bomb.png"
onready var hints = get_node("/root/main/UI/hints")

var takeable = true
var phase = 0

func _act():
	hints._write("Looks like i can assemble something here")
	if phase < 3 and player.ia != -1:
		print(player.inventory[player.ia])
		if player.inventory[player.ia] == "wires":
			player._erase()
			phase += 1
			$bits/wires.visible = true
			_hint()
			_check()
		elif player.inventory[player.ia] == "timer":
			player._erase()
			phase += 1
			$bits/timer.visible = true
			_hint()
			_check()
		elif player.inventory[player.ia] == "c4":
			player._erase()
			phase += 1
			$bits/c4.visible = true
			_hint()
			_check()

func _hint():
	if phase < 2:
		hints._write(str(3-phase) + " peices left")
	else:
		hints._write("1 peice left")

func _check():
	if phase == 3:
		hints._write("This thing can do some damage!")
		player._pickup(item, image)
		$StaticBody2D.collision_layer = 2
		$StaticBody2D.collision_mask = 2
		$StaticBody2D/Sprite.z_index = -1
		$bits.visible = false

func _process(_delta):
	$bits.modulate = $StaticBody2D/Sprite.self_modulate
