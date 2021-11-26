extends Node2D

export (PackedScene) var Boom

func _process(delta):
	position.y += 100 * delta
	if $Area2D/Sprite.scale.x < 2:
		$Area2D/Sprite.scale.x += 2 * delta
		$Area2D/Sprite.scale.y += 2 * delta

func _on_Area2D_body_entered(body):
	if body == get_node("/root/main/world/clock"):
		var node = Boom.instance()
		get_node("/root/main").call_deferred("add_child", node)
		node.global_position = body.global_position
		body.get_child(1).texture = load("res://assets/burnt_cannon.png")
		body.get_parent()._boom()
		get_node("/root/main/world/wintimer").start()
		get_node("/root/main/cannon/AudioStreamPlayer2D").queue_free()
		queue_free()
