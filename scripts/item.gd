extends StaticBody2D

func _death():
	get_parent().get_node("AnimationPlayer").play("burn")

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("burn"):
		get_parent().set_process(false)
		queue_free()

func _process(_delta):
	$Sprite2.self_modulate = $Sprite.self_modulate
