extends Node2D

export var obj_script : String

export var tex : String
export var size : int
export var vframes : int
export var grass_poz_x : int
export var grass_poz_y : int

var takeable = true
onready var player = get_node("/root/main/player")

func _ready():
	$body/glow.modulate = Color(8,8,8)
	$body/glow.texture = load(tex)
	$body/glow.vframes = vframes
	$body/Sprite.texture = load(tex)
	$body/Sprite.vframes = vframes
	$body.set_script(load(obj_script))
	$body._setup()
	$body/CollisionShape2D.scale.y *= size
	$body.hints = get_node("/root/main/UI/hints/Label")
	$body.player = get_node("/root/main/player")
	$body/Sprite2.position = Vector2(grass_poz_x, grass_poz_y)
	$body/Sprite2/shadow.global_position.x = $body/Sprite.global_position.x
	$body/Sprite2/shadow.scale *= size

func _death():
	$AnimationPlayer.play("burn")

func _no_take():
	takeable = false
	$body/glow.self_modulate.a = 0

func _on_AnimationPlayer_animation_finished(anim):
	if anim == ("burn"):
		queue_free()

func _process(_delta):
	var player_z_dif = player.get_child(0).global_position.y - $body/Sprite.global_position.y
	if player_z_dif > 0:
		z_index = 3
	elif player_z_dif < 0:
		z_index = 7
	$body/Sprite2.self_modulate = $body/Sprite.self_modulate
	if $body/glow.visible and takeable == false:
		$body/glow.visible = false

func _glow(boo):
	$body/glow.visible = boo

func _on_TouchScreenButton_pressed():
	if player.act_obj == $body and takeable:
		$body._act()
