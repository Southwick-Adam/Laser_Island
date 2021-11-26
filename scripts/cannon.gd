extends Node2D

export (PackedScene) var Bomb

onready var player = get_node("/root/main/player")
onready var hints = get_node("/root/main/UI/hints")

var takeable = true

func _act():
	hints._write("Got to load it before i can fire")
	if player.inventory[player.ia] == "bomb":
		hints._write("fire away!")
		player._erase()
		$AnimationPlayer.play("go")

func _process(_delta):
	$StaticBody2D/Sprite/sprite.modulate = $StaticBody2D/Sprite.self_modulate

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == ("go"):
		$AnimationPlayer2.play("boom")
		$AudioStreamPlayer2D.play()
		var node = Bomb.instance()
		get_node("/root/main").call_deferred("add_child", node)
		node.global_position = $Position2D.global_position

func _on_TouchScreenButton_pressed():
	if player.act_obj == self and takeable:
		_act()
