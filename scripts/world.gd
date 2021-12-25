extends Node2D

onready var player = get_node("/root/main/player")
onready var hints = get_node("/root/main/UI/hints")

onready var tileMap = $level/TileMap
onready var wallMap = $level/wall


var tiles = {}
var wall = {}
var time = 0

var takeable = true

func _ready():
	if not StoredData.sound:
		AudioServer.set_bus_mute(1,1)
	if not StoredData.music:
		AudioServer.set_bus_mute(2,1)
	AudioServer.set_bus_mute(0,0)
	for tile in tileMap.get_used_cells():
		var area = $check.duplicate()
		add_child(area)
		area.position = tileMap.map_to_world(tile) + Vector2(8,16)
		tiles[area] = tile
	$check.queue_free()
	for tile in wallMap.get_used_cells():
		var area = $check2.duplicate()
		add_child(area)
		area.position = wallMap.map_to_world(tile) + Vector2(8,16)
		wall[area] = tile
	$check2.queue_free()

func _start():
	$level/laser._start()
	$AudioStreamPlayer.play()
	$level/laser/body/beam/Sprite/hum.play()
	$level/laser/body/beam/Sprite/fire.play()

func _grey_out(tile):
	tileMap.set_cell(tile.x, tile.y, tileMap.get_cell(tile.x, tile.y) + 13)

func _boom():
	set_process(false)
	$clock/beam.visible = false
	$clock/beam.monitoring = false
	$clock/beam/Sprite/hum.playing = false
	$clock/beam/Sprite/burn.playing = false

func _on_wintimer_timeout():
	player.set_process(false)
	player.visible = false
