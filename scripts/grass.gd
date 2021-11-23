extends Area2D

func _death():
	get_parent().get_node("AnimationPlayer").play("burn")

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("burn"):
		get_parent().queue_free()
