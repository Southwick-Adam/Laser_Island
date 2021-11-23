extends Node2D

export (PackedScene) var Fire

onready var player = get_node("/root/main/player")
onready var hints = get_node("/root/main/UI/hints")

var tiles = {}
var shade = {}
var time = 0

var takeable = true

func _ready():
	if not StoredData.sound:
		AudioServer.set_bus_mute(1,1)
	if not StoredData.music:
		AudioServer.set_bus_mute(2,1)
	AudioServer.set_bus_mute(0,0)
	for tile in $TileMap.get_used_cells():
		var area = $check.duplicate()
		add_child(area)
		area.position = $TileMap.map_to_world(tile) + Vector2(16,16)
		tiles[area] = tile
	$check.queue_free()
	for tile in $shadow.get_used_cells_by_id(1):
		var area = $check2.duplicate()
		add_child(area)
		area.position = $shadow.map_to_world(tile) + Vector2(-10,16)
		shade[area] = tile
	$check2.queue_free()

func _process(delta):
	$clock.rotate(PI/30 * delta)

func _on_beam_area_entered(area):
	if area.is_in_group("check"):
		var node = Fire.instance()
		call_deferred("add_child", node)
		node.position = area.position
		var tile = tiles[area]
		node.tile = tile
		$TileMap.set_cell(tile.x, tile.y, $TileMap.get_cell(tile.x, tile.y) + 12)
		area.queue_free()
	elif area.is_in_group("check2"):
		var tile = shade[area]
		$shadow.set_cell(tile.x, tile.y, 0)
		area.queue_free()
	elif area.is_in_group("target"):
		area.get_parent().get_child(0)._death()

func _on_beam_body_entered(body):
	if body == get_node("/root/main/player/body"):
		body.get_parent()._death()

func _grey_out(tile):
	$TileMap.set_cell(tile.x, tile.y, $TileMap.get_cell(tile.x, tile.y) + 11)

func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationPlayer.play("laser")

func _boom():
	set_process(false)
	$clock/beam.visible = false
	$clock/beam.monitoring = false
	$clock/beam/Sprite/AudioStreamPlayer2D.playing = false
	$clock/beam/Sprite/AudioStreamPlayer2D2.playing = false

func _on_Timer_timeout():
	set_process(false)

func _act():
	hints._write("Let's stay far away from the death laser")

func _on_wintimer_timeout():
	$win/win.visible = true
	$win/Label.visible = true
	player.set_process(false)
	player.visible = false
