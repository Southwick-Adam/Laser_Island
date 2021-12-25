extends Node2D

export (PackedScene) var Fire

onready var world = get_parent().get_parent()
onready var level = get_parent()

onready var tiles = world.tiles
onready var wall = world.wall

onready var tileMap = level.get_child(0)
onready var wallMap = level.get_child(1)

func _ready():
	set_process(false)
	$Timer.wait_time = level.laser_time

func _start():
	$AnimationPlayer.play("laser_start")

func _on_beam_area_entered(area):
	if area.is_in_group("check"):
		var node = Fire.instance()
		world.call_deferred("add_child", node)
		node.position = area.position
		var tile = tiles[area]
		node.tile = tile
		tileMap.set_cell(tile.x, tile.y, tileMap.get_cell(tile.x, tile.y) + 13) #RED OUT
		area.queue_free()
	elif area.is_in_group("check2"):
		var tile = wall[area]
		wallMap.set_cell(tile.x, tile.y, wallMap.get_cell(tile.x, tile.y) + 9) #RED OUT
		area.queue_free()
	elif area.is_in_group("target"):
		area.get_parent()._death()

func _on_beam_body_entered(body):
	if body == get_node("/root/main/player/body"):
		body.get_parent()._death()

func _process(delta):
	rotate(PI/level.laser_rot_speed * delta * level.laser_rot_dir)
	var velocity = Vector2(level.laser_x_speed, level.laser_y_speed)
	global_position += velocity * delta

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("laser_start"):
		set_process(true)
		$Timer.start()
		$AnimationPlayer.play("laser")

func _on_Timer_timeout():
	set_process(false)

func _boom():
	set_process(false)
	$body/beam.visible = false
	$body/beam.monitoring = false
	$body/beam/Sprite/hum.playing = false
	$body/beam/Sprite/fire.playing = false
