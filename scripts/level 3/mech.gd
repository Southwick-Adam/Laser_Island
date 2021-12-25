extends Node2D

onready var player = get_node("/root/main/player")
var item = "bomb"
var image = "res://assets/level 3/bomb.png"
onready var hints = get_node("/root/main/UI/hints/Label")

var takeable = true
var phase = 0

func _act():
	hints.text = ("Looks like i can assemble something here")
	if phase < 3 and player.ia != -1:
		if player.inventory[player.ia] == "wires":
			player._erase()
			phase += 1
			$body/bits/wires.visible = true
			_hint()
			_check()
		elif player.inventory[player.ia] == "timer":
			player._erase()
			phase += 1
			$body/bits/timer.visible = true
			_hint()
			_check()
		elif player.inventory[player.ia] == "c4":
			player._erase()
			phase += 1
			$body/bits/c4.visible = true
			_hint()
			_check()

func _hint():
	if phase < 2:
		hints.text = (str(3-phase) + " peices left")
	else:
		hints.text = ("1 peice left")

func _check():
	if phase == 3:
		hints.text = ("This thing can do some damage!")
		player._pickup(item, image)
		$body.collision_layer = 2
		$body.collision_mask = 2
		$body/bits.visible = false
		takeable = false
		$body/glow.modulate.a = 0

func _process(_delta):
	$body/bits.modulate = $body/Sprite.self_modulate

func _glow(boo):
	$body/glow.visible = boo

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()

func _death():
	$AnimationPlayer.play("burn")
