extends Node2D

onready var map = get_node("/root/main/world/TileMap")

func _on_Timer_timeout():
	map.set_cell(6,7,26)

func _on_Timer2_timeout():
	map.set_cell(3,7,27)
	queue_free()
