extends Node2D

onready var map = get_node("/root/main/world/level/TileMap")

func _on_Timer_timeout():
	map.set_cell(6,7,34)

func _on_Timer2_timeout():
	map.set_cell(3,7,30)
	queue_free()
