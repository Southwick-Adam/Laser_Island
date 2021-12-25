extends StaticBody2D

func _ready():
	$glow.modulate = Color(8,8,8)

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("burn"):
		get_parent().queue_free()

func _act():
	get_parent()._act()
