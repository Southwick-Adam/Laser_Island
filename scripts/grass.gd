extends Node2D

onready var player = get_node("/root/main/player")

func _death():
	$AnimationPlayer.play("burn")

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("burn"):
		queue_free()

func _process(_delta):
	var player_z_dif = player.get_child(0).global_position.y - global_position.y
	if player_z_dif >= -10:
		z_index = 3
	elif player_z_dif < -10:
		z_index = 7
